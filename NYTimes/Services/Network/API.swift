//
//  API.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//

enum API {
    case mostViewedArticle(section:String, period:Int)
    case mostSharedArticle(period:Int) // consider if you want to add some more path
    
    var pathUrl: String {
        var pathUrlRef = ""
        
        switch self {
        case .mostViewedArticle(let section, let period):
            pathUrlRef = "/svc/mostpopular/v2/mostviewed/\(section)/\(period).json"
        case .mostSharedArticle(let period):
            pathUrlRef = "svc/mostpopular/v2/shared/\(period).json"
        }
        
        return pathUrlRef
    }
    
    
    var endPoint: String {
        return Configuration.baseURL + pathUrl
    }
    
}
