//
//  ArticleContentView.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//
import SwiftUI
struct ArticleContentView: View {
    let article: Article
    let showWebView: Bool = false
    
    var body: some View {
        if showWebView == false {
            ArticleDetailView(article: article)
        } else {
            WebView(url: URL(string: article.url)!)
                .navigationTitle(StringConstants.detail)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
