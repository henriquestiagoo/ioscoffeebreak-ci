#if canImport(SwiftUI)
import SwiftUI

struct IssuePreview: View {
    let colors: [Color]
    let foregroundColor: Color
    let title: String
    let date: Date
    let issueNumber: Int

    let gradient: Gradient

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "en-US")
        return dateFormatter
    }()

    public init(
        colors: [Color],
        foregroundColor: Color,
        title: String,
        date: Date, 
        issueNumber: Int
    ) {
        self.colors = colors
        self.foregroundColor = foregroundColor
        self.title = title
        self.date = date
        self.issueNumber = issueNumber

        self.gradient = Gradient(colors: colors)
    }

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                gradient: gradient,
                startPoint: .trailing,
                endPoint: .center
            )

            VStack(alignment: .leading, spacing: 10) {
                Spacer(minLength: 0)
                VStack(alignment: .leading) {
                    Text("ioscoffeebreak.com")
                        .font(.system(size: 24))
                        .opacity(0.8)
                    Text(title)
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                }
                Spacer(minLength: 0)
                HStack(alignment: .firstTextBaseline) {
                    Text("iOS Coffee Break Newsletter")
                        .fontWeight(.semibold)
                    Text("•")
                    Text("Issue #\(issueNumber)")
                    Spacer()
                    Text(dateFormatter.string(from: date))
                }
                .font(.system(size: 24))
                .opacity(0.8)
            }
            .padding(80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(foregroundColor)
    }
}

#endif
