// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ioscoffeebreakci",
    platforms: [
        .macOS("13.0")
    ],
    products: [
        .executable(
            name: "issuepreview",
            targets: ["IssuePreviewGenerator"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .exact("1.2.3"))
    ],
    targets: [
        .executableTarget(
            name: "IssuePreviewGenerator",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)
