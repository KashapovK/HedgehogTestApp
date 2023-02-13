//
//  MainRouter.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import UIKit

final class MainRouter: RouterProtocol {
    //MARK: - Properties
    private var navigationController: UINavigationController
    
    //MARK: - Initialize
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - RouterProtocol methods
    func initialViewController() {
        let mainSearchViewController = MainSearchModuleAssembly.createMainSearchModule(router: self)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers = [mainSearchViewController]
    }
    
    func pushToDetailViewController(with currentViewModel: ViewModel, viewModels: [ViewModel]) {
        let detailInfoViewController = DetailInfoModuleAssembly
            .createDetailInfoViewController(with: currentViewModel,
                                            viewModels: viewModels,
                                            router: self)
        navigationController.pushViewController(detailInfoViewController, animated: true)
    }
    
    func openWkWebView(with urlString: String) {
        let webViewController = WebViewController(urlString: urlString)
        navigationController.present(webViewController, animated: true)
    }
}
