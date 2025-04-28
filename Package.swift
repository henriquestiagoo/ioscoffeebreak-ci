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
        ),
        .executable(
            name: "feedparser",
            targets: ["FeedParser"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "IssuePreviewGenerator",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .executableTarget(
            name: "FeedParser",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)
