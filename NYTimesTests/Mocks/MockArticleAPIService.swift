//
//  MockArticleAPIService.swift
//  NYTimes
//
//  Created by Raja Indirajith on 12/07/2025.
//

import Foundation
import XCTest

@testable import NYTimes
class MockArticleAPIService: ArticleAPIServiceProtocol {
    var shouldReturnError = false
   

    func fetchMostViewed(_ section: String, period: Int) async throws -> [Article] {
        if shouldReturnError {
            throw APIError
                .serverError(statusCode: -1)
        } else {
            var jsonData:Data?
            if period == 1 {
                jsonData = loadJSONData(from: "SampleArticleList_1d")
            }else {
                jsonData = loadJSONData(from: "SampleArticleList")
            }
            let decoder = JSONDecoder()
            let mostViewedResponse = try! decoder.decode(ArticleListResponse.self, from: jsonData!)
            return mostViewedResponse.results
        }
    }
    
    func loadJSONData(from fileName: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Missing file: \(fileName).json")
        }
        return try! Data(contentsOf: url)
    }
}
