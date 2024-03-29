// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// Structure for previews.
struct Preview: Codable {
    let title: String
    let description: String
    let author: String
    let createdAt: Date
    let version: String
    let content: Content
    
    struct Content: Codable {
        let sections: [Section]
        let images: [Media]
        let videos: [Media]
        let links: [Link]
        
        struct Section: Codable {
            let title: String
            let content: String
        }
        
        struct Media: Codable {
            let title: String
            let url: URL
            let description: String
        }
        
        struct Link: Codable {
            let title: String
            let url: URL
            let description: String
        }
    }
}

// Example instance of the Preview struct
let previewModel = Preview(
    title: "Example Preview",
    description: "This is an example JSON structure for a preview.",
    author: "Your Name",
    createdAt: Date(),
    version: "1.0",
    content: Preview.Content(
        sections: [
            Preview.Content.Section(title: "Section 1", content: "This is the content of section 1."),
            Preview.Content.Section(title: "Section 2", content: "This is the content of section 2.")
        ],
        images: [
            Preview.Content.Media(title: "Image 1", url: URL(string: "https://example.com/image1.jpg")!, description: "Description of Image 1"),
            Preview.Content.Media(title: "Image 2", url: URL(string: "https://example.com/image2.jpg")!, description: "Description of Image 2")
        ],
        videos: [
            Preview.Content.Media(title: "Video 1", url: URL(string: "https://example.com/video1.mp4")!, description: "Description of Video 1"),
            Preview.Content.Media(title: "Video 2", url: URL(string: "https://example.com/video2.mp4")!, description: "Description of Video 2")
        ],
        links: [
            Preview.Content.Link(title: "Link 1", url: URL(string: "https://example.com/link1")!, description: "Description of Link 1"),
            Preview.Content.Link(title: "Link 2", url: URL(string: "https://example.com/link2")!, description: "Description of Link 2")
        ]
    )
)
