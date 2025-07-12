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
    
    var apiService:ArticleAPIServiceProtocol
    
    init(apiService: ArticleAPIServiceProtocol = ArticleAPIService()) {
        self.apiService = apiService
    }

    func loadArticlesIfNeeded() async {
        guard !hasLoaded else { return }
        hasLoaded = true
        await fetchMostViewedArticles()
    }
    
    @MainActor
    func fetchMostViewedArticles() async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            let fetchedArticles:[Article] = try await apiService.fetchMostViewed(
                articlesFilterSection,
                period: selectedPeriod.rawValue
            )
            
            articles = fetchedArticles.sorted {
                $0.lastModifiedDate > $1.lastModifiedDate
            }
            apiError = nil
            
        } catch {
            apiError = ErrorWrapper(message: error.localizedDescription)
        }
    }
}
