import Foundation

struct MarkdownGen {
    static func makeContent(from issues: [Issue]) -> String {
        // format the model data into a string
        let formattedIssues = issues
            .map(\.markdown)
            .joined(separator: "\n")

        // format the string to markdown
        return """
        # iOS Coffee Break CI/CD Engine

        Hi! 👋

        This repository holds the issue blogging engine I have built for my [iOS Coffee Break Newsletter](https://www.ioscoffeebreak.com).

        ## Latest issues in my [newsletter](https://www.ioscoffeebreak.com)
        \(formattedIssues)

        Feel free to [reach me](mailto:info.ioscoffeebreak@gmail.com) out for a coffee ☕

        ~Tiago, iOS Coffee Break.
        """
    }
}
