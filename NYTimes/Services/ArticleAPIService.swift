//
//  ArticleAPIService.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//

protocol ArticleAPIServiceProtocol {
    func fetchMostViewed(_ section: String, period: Int) async throws -> ArticleListResponse
}


class ArticleAPIService:ArticleAPIServiceProtocol  {
   
    func fetchMostViewed(_ section: String, period: Int) async throws -> ArticleListResponse {
        let queryParams: [String: Any] = [StringConstants.api_key:Configuration.api_key]
        let response:ArticleListResponse = try await NetworkService.shared.performRequest(
            urlStr: API.mostViewedArticle(
                section: section,
                period: period
            ).endPoint,
            body: nil as Empty?, queryParms: queryParams
            )
        return response
    }
        
}
