//
//  CodableEditorViewModel.swift
//  
//
//  Created by Tibor Felföldy on 2024-03-29.
//

import Foundation

@Observable
final class CodableEditorViewModel<Model: Codable> {
    var source = ""
    var isErrorPresented = false
    private(set) var editorError: EditorError?
    
    private let model: Model
    private let saveCompletion: (Model) -> Void
    
    init(model: Model, saveCompletion: @escaping (Model) -> Void) {
        self.model = model
        self.saveCompletion = saveCompletion
        load()
    }

    func load() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        
        handleErrors {
            let data = try encoder.encode(model)
            source = String(data: data, encoding: .utf8) ?? ""
        }
    }
    
    func save() throws {
        let decoder = JSONDecoder()
        
        let data = source.data(using: .utf8) ?? Data()

        let model = try decoder.decode(Model.self, from: data)
        saveCompletion(model)
    }
    
    func handleErrors(block: () throws -> Void) {
        do {
            try block()
        } catch {
            if let decodingError = error as? DecodingError {
                print(decodingError)
                editorError = .failedDecoding(decodingError)
            } else {
                editorError = .general(error)
            }
            isErrorPresented = true
        }
    }
}

extension CodableEditorViewModel {
    enum EditorError: LocalizedError {
        case general(Error)
        case failedDecoding(DecodingError)
        
        var errorDescription: String? {
            switch self {
            case let .general(error):
                error.localizedDescription
                
            case let .failedDecoding(decodingError):
                switch decodingError {
                case let .typeMismatch(type, context):
                    context.debugDescription
                case let .valueNotFound(value, context):
                    context.debugDescription
                case let .keyNotFound(codingKey, context):
                    context.debugDescription
                case let .dataCorrupted(context):
                    context.debugDescription
                @unknown default:
                    decodingError.localizedDescription
                }
            }
        }
        
        var failureReason: String? {
            switch self {
            case .general: nil
                
            case let .failedDecoding(decodingError):
                switch decodingError {
                case let .dataCorrupted(context):
                    context.underlyingError?.infoDescription
                case let .typeMismatch(_, context):
                    context.codingPath.last?.stringValue
                    
                default: nil
                }
            }
        }
    }
}

extension Error {
    var infoDescription: String? {
        (self as NSError)
            .userInfo[NSDebugDescriptionErrorKey] as? String
    }
}
