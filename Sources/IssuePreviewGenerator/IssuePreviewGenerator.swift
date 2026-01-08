
#if canImport(AppKit)
import AppKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
import ArgumentParser
import Foundation

@main
struct issuepreview: AsyncParsableCommand {
    @Option(name: .shortAndLong, help:  "The json file of the issue.")
    var issue: String

    @MainActor mutating func run() async throws {
        let manager = FileManager.default
        let colors = [
            Color(#colorLiteral(red: 155/255, green: 70/255, blue: 70/255, alpha: 1)),
            Color(#colorLiteral(red: 81/255, green: 28/255, blue: 28/255, alpha: 1))
        ]
        let foreground = Color.white
        let date = Date()

        let json = try String(contentsOfFile: issue)
        let githubIssue = try decode(json: json)
        guard let jsonBodyData = githubIssue.body.data(using: .utf8),
              let issue: Issue = try? JSONDecoder().decode(Issue.self, from: jsonBodyData) else { throw Error.jsonBodyHasInvalidKeys }

        let view = IssuePreview(
            colors: colors,
            foregroundColor: foreground,
            title: issue.title,
            date: date,
            issueNumber: issue.number
        )
        .frame(width: 1280, height: 640)

        guard let image = ImageRenderer(content: view).nsImage else { throw Error.invalidImageData }
        guard let imageData = image.asPNGData else { throw Error.imageCreationFailed }

        let folderURL = URL(fileURLWithPath: "issues")

        if !manager.fileExists(atPath: folderURL.relativePath) {
            try manager.createDirectory(
                at: folderURL,
                withIntermediateDirectories: false,
                attributes: nil
            )
        }

        let fileURL = folderURL.appendingPathComponent("\(issue.number).png")
        try imageData.write(to: fileURL)
    }

    func decode(json: String) throws -> GitHubIssue {
        return try JSONDecoder().decode(GitHubIssue.self, from: Data(json.utf8))
    }

}
