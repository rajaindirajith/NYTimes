//
//  StringConstants.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//


struct StringConstants {
    
    //Navigation Title
    static let NYT_Articles = "NYT - Most Popular"
    static let detail = "Detail"
    
    //UI
    static let last_updated = "Last Updated:"
    static let read_full_article = "Read Full Article"
    static let loadingArticles = "Loading articles..."
    static let errorTitle = "Error"
    static let ok = "Ok"
    static let last_1_day = "Last 1 Day"
    static let last_7_days = "Last 7 Days"
    static let last_30_days = "Last 30 Days"
    static let select_date_range = "Select Date Range"
    

    //Api request
    static let api_key = "api-key"
    static let application_json = "application/json"
    static let content_type = "Content-Type"
    
    
    
    
    //APIError string
    static let invalidURL = "The URL provided was invalid."
    static let noInternetConnectionMessage = "No internet connection. Please check your network settings."
    
    static func apiParsingErrorMessage(for error: Error) -> String {
           "Failed to parse the response: \(error.localizedDescription)"
    }
    static func apiUnknownErrorMessage(for error: Error) -> String {
           "Failed to parse the response: \(error.localizedDescription)"
    }
    static func serverErrorMessage(for statusCode: Int) -> String {
           "Server error (code \(statusCode))."
    }
    
   
}
