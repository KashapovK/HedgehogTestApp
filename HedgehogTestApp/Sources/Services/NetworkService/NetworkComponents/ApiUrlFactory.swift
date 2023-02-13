//
//  ApiUrlFactory.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

enum ApiUrlFactory {
    case imageData(query: String)
    
    var url: URL {
        switch self {
        case .imageData(let query):
            return configureUrl(with: DefaultComponents.baseUrl, endpoint: DefaultComponents.headlinersPath,
                                queryParametrs: ["q": "\(query)",
                                                 "tbm": "\(DefaultComponents.searchType)",
                                                 "api_key": "\(DefaultComponents.apiKey)",
                                                 "ijn": DefaultComponents.page])
        }
    }
    
    private func configureUrl(with baseURL: String,
                              endpoint: String,
                              queryParametrs: [String: Any]) -> URL {
        guard let url = URL(string: baseURL)?.appendingPathComponent(endpoint),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return URL(fileURLWithPath: "")
        }
        
        urlComponents.queryItems = queryParametrs.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        guard let url = urlComponents.url else { return URL(fileURLWithPath: "") }
        
        return url
    }
}
