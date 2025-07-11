//
//  ArticleListResponse.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//


struct ArticleListResponse: Decodable {
    let status: String
    let numResults: Int
    let results: [Article]

    enum CodingKeys: String, CodingKey {
        case status
        case numResults = "num_results"
        case results
    }
}
