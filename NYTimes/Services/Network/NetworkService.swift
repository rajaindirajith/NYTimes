//
//  NetworkService.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

enum NetworkError: Error {
    case invalidURL
    case noInternetConnection
    case serverError(statusCode: Int)
    case decodingError(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noInternetConnection:
            return "No internet connection. Please check your network settings."
        case .serverError(let statusCode):
            return "Server error (code \(statusCode))."
        case .decodingError(let error):
            return "Failed to parse the response: \(error.localizedDescription)"
        case .unknown(let error):
            return "Unexpected error: \(error.localizedDescription)"
        }
    }
}

protocol NetworkServiceProtocol {
    func performRequest<T: Decodable, E:Encodable>(
        urlStr: String,
        method: HTTPMethod,
        body: E?,
        queryParms:[String: Any]?,
        headers: [String: String]?
    ) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    
    private init() {}
    
    static let shared = NetworkService()
    
    func performRequest<T, E>(urlStr: String, method: HTTPMethod = .GET, body: E? = nil, queryParms: [String : Any]? = nil, headers: [String : String]? = nil) async throws -> T where T : Decodable, E : Encodable {
        
        return try JSONDecoder().decode(T.self, from: Data())
    }
}
