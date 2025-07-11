//
//  ArticleListViewModel.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//

import Foundation
import Combine


enum ArticlePeriod: Int, CaseIterable, Identifiable {
    case oneDay = 1
    case sevenDays = 7
    case thirtyDays = 30

    var id: Int { rawValue }  // for use in Picker

    var title: String {
        switch self {
        case .oneDay: return StringConstants.last_1_day
        case .sevenDays: return StringConstants.last_7_days
        case .thirtyDays: return StringConstants.last_30_days
        }
    }
}


class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var apiError: ErrorWrapper? = nil
    @Published var isLoading: Bool = false
    @Published var selectedPeriod: ArticlePeriod = .sevenDays {
       didSet {
           Task {
               await fetchMostViewedArticles()
           }
       }
    }
    
    let articlesFilterSection = "all-sections"
    var hasLoaded = false
    
    private lazy var apiService = ArticleAPIService()

    func loadArticlesIfNeeded() async {
        
           guard !hasLoaded else { return }
           hasLoaded = true
           await fetchMostViewedArticles()
       }
    
    func fetchMostViewedArticles() async {
        await MainActor.run { isLoading = true }
        defer {
            Task { await MainActor.run { isLoading = false } }
        }
        
        do {
            let articlesResponse:ArticleListResponse = try await apiService.fetchMostViewed(
                articlesFilterSection,
                period: selectedPeriod.rawValue
            )
            
            await MainActor.run {
                articles = articlesResponse.results.sorted {
                    $0.lastModifiedDate > $1.lastModifiedDate 
                }
                apiError = nil
            }
                       
            
        } catch {
            await MainActor.run {
               apiError = ErrorWrapper(message: error.localizedDescription)
            }
        }
    }
}
