//
//  ArticleListViewModel.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//

import Foundation
import Combine

class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var errorMessage: String? = nil
}
