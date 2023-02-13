//
//  MainSearchPresenter.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

final class MainSearchPresenter: MainSearchPresenterInputProtocol {
    
    // MARK: - Properties
    weak var view: MainSearchPresenterOutputProtocol?
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol
    
    // MARK: - Initialize
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
    }
    
    // MARK: - MainSearchPresenterInputProtocol methods
    func getDataFromNet(with query: String) {
        let request = ImageDataRequestFactory.imageData(query: query).urlRequest
        networkService.fetchImageData(from: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.prepareDataToConfigureCell(responceData: data)
                
            case .failure(let error):
                self.view?.configureAlert(with: error)
            }
        }
    }
    
    func emptyDataResult() {
        let emptyData = ResultResponce(imagesResults: [])
        prepareDataToConfigureCell(responceData: emptyData)
    }
    
    func pushToDetailInfoViewController(with currentViewModel: ViewModel, viewModels: [ViewModel]) {
        router.pushToDetailViewController(with: currentViewModel, viewModels: viewModels)
    }
}

// MARK: - Private methods
extension MainSearchPresenter {
    private func prepareDataToConfigureCell(responceData: ResultResponce) {
        let cellViewModels = responceData.imagesResults.map {
            return  ImageDataViewModel(id: $0.position,
                                       imageUrlString: $0.thumbnail,
                                       sourceImageUrlString: $0.link)
        }
        view?.configureView(with: cellViewModels)
    }
}
