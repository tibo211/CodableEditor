//
//  CodableEditorView.swift
//  
//
//  Created by Tibor Felföldy on 2024-03-29.
//

import SwiftUI
import CodeEditor

public struct CodableEditorView<Model: Codable>: View {
    @State var viewModel: CodableEditorViewModel<Model>
    @Environment(\.dismiss) var dismiss
    
    public var body: some View {
        NavigationStack {
            CodeEditor(
                source: $viewModel.source,
                language: .json,
                theme: .nord
            )
            .navigationTitle("\(String(describing: Model.self)) Editor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("save", systemImage: "square.and.arrow.down") {
                        viewModel.save()
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("close", systemImage: "x.circle") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Button("reset", systemImage: "arrow.counterclockwise.circle") {
                        viewModel.load()
                    }
                }
            }
            .alert(isPresented: $viewModel.isErrorPresented,
                   error: viewModel.editorError) { _ in
                // Ok button.
            } message: { error in
                if let reason = error.failureReason {
                    Text(reason)
                }
            }
        }
    }
}

extension CodeEditor.ThemeName {
    static let nord = CodeEditor.ThemeName(rawValue: "nord")
}

extension View {
    @ViewBuilder
    func editable<Model: Identifiable>(_ model: Binding<Model?>, save: @escaping (Model) -> Void) -> some View where Model: Codable {
        sheet(item: model) { model in
            let viewModel = CodableEditorViewModel(model: model, saveCompletion: save)
            CodableEditorView(viewModel: viewModel)
        }
    }
}

#Preview {
    VStack {
        let viewModel = CodableEditorViewModel(model: previewModel) { model in
            print("Save \(model)")
        }
        
        CodableEditorView(viewModel: viewModel)
    }
}
