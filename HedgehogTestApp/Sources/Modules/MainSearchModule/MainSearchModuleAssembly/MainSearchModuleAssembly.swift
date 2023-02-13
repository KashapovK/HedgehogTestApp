//
//  MainSearchModuleAssembly.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import UIKit

final class MainSearchModuleAssembly {
    static func createMainSearchModule(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let presenter = MainSearchPresenter(networkService: networkService, router: router)
        let view = MainSearchViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
