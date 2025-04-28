import ArgumentParser
import Foundation

@main
struct feedparser: AsyncParsableCommand {
    @Argument(help: "The path of the destination README file.")
    var destination: String

    func run() async throws {
        let apiClient = APIClient()

        do {
            // fetch issues from the newsletter API
            let issues = try await apiClient.getIssues()
            let latestIssues = (issues.count < 10) ? issues : Array(issues.prefix(10))
            // generate content from latest issues
            let content = MarkdownGen.makeContent(from: latestIssues)
            // write to the README.md file
            try content.write(to: URL(fileURLWithPath: destination), atomically: true, encoding: .utf8)
            print("✅ Successfully written to \(destination) file.")
        } catch let error {
            print("❌ Error: \(error)")
        }
    }
}
