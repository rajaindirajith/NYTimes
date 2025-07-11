import SwiftUI

struct ArticleRowView: View {
    let article: Article

    let viewHeight = 200.0
    let gradientHeight = 110.0

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = article.largeURL ?? article.mediumURL ?? article.thumbnailURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: viewHeight)
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: viewHeight)
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: viewHeight)
            }

            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.black.opacity(0.85), location: 0),
                    .init(color: Color.black.opacity(0.7), location: 0.3),
                    .init(color: Color.black.opacity(0.3), location: 0.7),
                    .init(color: Color.clear, location: 1)
                ]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: gradientHeight)
            .frame(maxWidth: .infinity)
            .allowsHitTesting(false)

            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.title3).bold()
                    .foregroundColor(.white)
                    .lineLimit(3)

                HStack {
                    Text(article.byline)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.75))
                        .lineLimit(2)
                        .truncationMode(.tail)

                    Spacer()

                    Text(article.dateToDisplay)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.75))
                }
            }
            .padding()
        }
        .frame(height: viewHeight)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 4)
    }
}


