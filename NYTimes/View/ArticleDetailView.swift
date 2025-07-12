//
//  ArticleDetailView.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    let imageHeight = 240.0
    let gradientHeight = 120.0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Thumbnail with overlay title + gradient
                ZStack(alignment: .bottomLeading) {
                    // Show image if available
                    if let imageURL = article.largeURL ?? article.mediumURL ?? article.thumbnailURL {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: imageHeight)
                                .clipped()
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: imageHeight)
                        }
                    } else {
                        // Fallback if no image
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: imageHeight)
                    }

                    // Gradient overlay (always present)
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: gradientHeight)

                    // Title text (always present)
                    Text(article.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .lineLimit(5)
                }
                .frame(height: imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 4)
                .padding(.horizontal)


                // Article details
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.byline).font(.subheadline).foregroundColor(.secondary)

                    Text(StringConstants.last_updated + article.dateToDisplay)
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(article.abstract)
                        .font(.body)
                        .padding(.top)

                    Link(destination: URL(string: article.url)!) {
                        HStack(spacing: 4) {
                            Text(StringConstants.read_full_article)
                                .underline()
                            Image(systemName: "arrow.up.right.square")
                        }
                        .font(.footnote)
                        .foregroundColor(.blue)
                    }
                        
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(StringConstants.detail)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    let sampleArticle = Article(
        id: 100000010241467,
        url: "https://www.nytimes.com/interactive/2025/movies/best-movies-21st-century.html",
        publishedDate: "2025-06-22",
        updated: "2025-07-02 14:48:08",
        byline: "By The New York Times",
        title: "The 100 Best Movies of the 21st Century",
        abstract: "More than 500 influential directors, actors and other notable names in Hollywood and around the world voted on the best films released since Jan. 1, 2000. See how their ballots stacked up.",
        media: [
            Media(
                type: "image",
                subtype: "",
                mediaMetadata: [
                    MediaMetadata(
                        url: "https://static01.nyt.com/images/2025/07/10/arts/100films-static-day-5/100films-static-05-thumbStandard.jpg",
                        format: "Standard Thumbnail",
                        height: 75,
                        width: 75
                    ),
                    MediaMetadata(
                        url: "https://static01.nyt.com/images/2025/07/10/arts/100films-static-day-5/100films-static-05-mediumThreeByTwo210.jpg",
                        format: "mediumThreeByTwo210",
                        height: 140,
                        width: 210
                    ),
                    MediaMetadata(
                        url: "https://static01.nyt.com/images/2025/07/10/arts/100films-static-day-5/100films-static-05-mediumThreeByTwo440.jpg",
                        format: "mediumThreeByTwo440",
                        height: 293,
                        width: 440
                    )
                ]
            )
        ]
    )
    ArticleDetailView(article: sampleArticle)
}
