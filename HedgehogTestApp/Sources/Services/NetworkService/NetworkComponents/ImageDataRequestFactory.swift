//
//  ImageDataRequestFactory.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

enum ImageDataRequestFactory {
    case imageData(query: String)
    
    var urlRequest: URLRequest {
        switch self {
        case .imageData(let query):
            return createRequest(url: ApiUrlFactory.imageData(query: query).url)
        }
    }
    
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        request.timeoutInterval = 10
        
        return request
    }
}
