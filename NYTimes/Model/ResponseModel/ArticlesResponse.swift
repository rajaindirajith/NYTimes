//
//  Untitled.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//


struct ArticlesResponse: Decodable {
    let status: String
    let copyright: String
    let num_results: Int
    let results: [Article]
}
