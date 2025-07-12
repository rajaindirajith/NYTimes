//
//  ArticleListView.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject private var viewModel = ArticleListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading /*&& viewModel.articles.isEmpty*/ {
                    // Show ProgressView while loading initial data
                    ProgressView(StringConstants.loadingArticles)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.articles) { article in
                        NavigationLink(destination: ArticleContentView(article: article)) {
                            ArticleRowView(article: article)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.fetchMostViewedArticles()
                    }
                }
            }
            .navigationTitle(StringConstants.NYT_Articles)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Text(StringConstants.select_date_range)
                                       .font(.headline)
                                       .foregroundColor(.primary)
                        Picker("", selection: $viewModel.selectedPeriod) {
                               ForEach(ArticlePeriod.allCases) { period in
                                   Text(period.title).tag(period)
                               }
                        }
                    
                    } label: {
                        Label("", systemImage: "line.horizontal.3.decrease.circle")
                    }
                }
            }

            .alert(item: $viewModel.apiError) { error in
                Alert(
                    title: Text(StringConstants.errorTitle),
                    message: Text(error.message),
                    dismissButton: .default(Text(StringConstants.ok))
                )
            }
            .task {
                await viewModel.loadArticlesIfNeeded()
            }
        }
    }
}

#Preview {
    ArticleListView()
}

