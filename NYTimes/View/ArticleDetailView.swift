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
   // ArticleDetailView()
}
