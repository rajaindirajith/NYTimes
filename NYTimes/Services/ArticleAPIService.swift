//
//  ArticleAPIService.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//

protocol ArticleAPIServiceProtocol {
    func fetchMostViewed(_ section: String, period: Int) async throws -> [Article]
}


class ArticleAPIService:ArticleAPIServiceProtocol  {
    func fetchMostViewed(_ section: String, period: Int) async throws -> [Article] {
        return []
    }

    
   
        
}
