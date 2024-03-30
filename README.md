# JSON Editor for SwiftUI

A SwiftUI package that provides a convenient and efficient way to edit the JSON representation of models directly within your app.

## Example Usage

To integrate the JSON Editor into your SwiftUI view, you can use the `jsonSheetEditor` modifier. Here's a basic example that demonstrates how to present and use the editor with a model:

```swift
import SwiftUI
import CodableEditor

struct ContentView: View {
    @State private var showUserEditor: User?

    var body: some View {
        Button("Edit User") {
           showUserEditor = User(id: 1, name: "John Doe")
        }
        .jsonSheetEditor($showUserEditor) { updatedUser in
            // Handle the updated user, e.g., save to a database or update the UI.
            print("Updated User: \(updatedUser)")
        }
    }
}

struct User: Identifiable, Codable {
    var id: Int
    var name: String
}
```
