//
//  RouterProtocol.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

protocol RouterProtocol {
    func initialViewController()
    func pushToDetailViewController(with currentViewModel: ViewModel, viewModels: [ViewModel])
    func openWkWebView(with urlString: String)
}
