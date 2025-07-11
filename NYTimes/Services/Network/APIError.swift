//
//  APIError.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//

enum APIError: Error {
    case invalidURL
    case noInternetConnection
    case serverError(statusCode: Int)
    case decodingError(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return StringConstants.invalidURL
        case .noInternetConnection:
            return StringConstants.noInternetConnectionMessage
        case .serverError(let statusCode):
            return StringConstants.serverErrorMessage(for: statusCode)
        case .decodingError(let error):
            return StringConstants.apiParsingErrorMessage(for: error)
        case .unknown(let error):
            return StringConstants.apiUnknownErrorMessage(for: error)
            
        }
    }
}
