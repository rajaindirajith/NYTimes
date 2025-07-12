//
//  ArticleListViewModelTests.swift
//  NYTimes
//
//  Created by Raja Indirajith on 12/07/2025.
//

import XCTest
@testable import NYTimes

final class ArticleListViewModelTests: XCTestCase {
    
    func testFetchArticlesFailure() async {
        // Arrange
        let mockService = MockArticleAPIService()
        mockService.shouldReturnError = true  //triggers the error

        let viewModel = ArticleListViewModel(apiService: mockService)
        viewModel.selectedPeriod = .sevenDays
        // Act
        await viewModel.fetchMostViewedArticles()

        // Assert
        XCTAssertTrue(viewModel.articles.isEmpty)
        XCTAssertNotNil(viewModel.apiError)
    }

    func testFetchArticlesSuccess() async {
        // Arrange
        let mockService = MockArticleAPIService()

        let viewModel = ArticleListViewModel(apiService: mockService)
        viewModel.selectedPeriod = .sevenDays

        // Act
        //SampleArticleList loading
        await viewModel.fetchMostViewedArticles()

        // Assert
        XCTAssertEqual(viewModel.articles.count, 2)
        XCTAssertNil(viewModel.apiError)
    }
    
    func testSelectedPeriodTriggersFetch() async {
        // Arrange
        let mockService = MockArticleAPIService()

        let viewModel = ArticleListViewModel(apiService: mockService)
        viewModel.selectedPeriod = .oneDay

        // Act
        //SampleArticleList_1d loading
        await viewModel.fetchMostViewedArticles()

        // Assert
        XCTAssertEqual(viewModel.articles.count, 2)
        XCTAssertEqual(viewModel.articles.first?.title, "New York City Mayoral Primary Election Results")
        XCTAssertNil(viewModel.apiError)
    }
    
}

