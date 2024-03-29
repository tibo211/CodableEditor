// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodableEditor",
    platforms: [.iOS(.v17), .macOS(.v14), .visionOS(.v1)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CodableEditor",
            targets: ["CodableEditor"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ZeeZide/CodeEditor.git", branch: "main")
    ],
    targets: [
        .target(name: "CodableEditor",
                dependencies: [.byName(name: "CodeEditor")]),
        .testTarget(
            name: "CodableEditorTests",
            dependencies: ["CodableEditor"]),
    ]
)
