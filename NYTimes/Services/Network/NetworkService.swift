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
        
        
        // Create URLComponents from base URL string
        guard var components = URLComponents(string: urlStr) else {
           throw  NetworkError.invalidURL
        }

        // Add query parameters if provided
        if let queryParms = queryParms {
           components.queryItems = queryParms.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }

        // Final URL
        guard let url = components.url else {
           throw  NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Add headers
        headers?.forEach { key, value in
           request.addValue(value, forHTTPHeaderField: key)
        }

        // Add body if any
        if let body = body {
               request.httpBody = try JSONEncoder().encode(body)
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // send the request
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.serverError(statusCode: -1)
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }

        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                throw NetworkError.noInternetConnection
            default:
                throw NetworkError.unknown(urlError)
            }
        } catch {
            throw NetworkError.unknown(error)
        }
    }
    
}
