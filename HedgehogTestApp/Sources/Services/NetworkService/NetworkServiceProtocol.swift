//
//  NetworkServiceProtocol.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchImageData(from request: URLRequest,
                        completion: @escaping (Result<ResultResponce, NetworkError>) -> Void)
}
