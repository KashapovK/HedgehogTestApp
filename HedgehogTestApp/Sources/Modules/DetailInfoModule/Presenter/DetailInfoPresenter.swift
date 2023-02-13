//
//  DetailInfoPresenter.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

final class DetailInfoPresenter: DetailInfoPresenterInputProtocol {
    
    // MARK: - Properties
    weak var view: DetailInfoPresenterOutputProtocol?
    private let router: RouterProtocol
    private let viewModels: [ViewModel]
    private var currentViewModel: ViewModel
    private var index: Int = 0
    
    // MARK: - Initialize
    init(currentViewModel: ViewModel,
         viewModels: [ViewModel],
         router: RouterProtocol) {
        self.currentViewModel = currentViewModel
        self.viewModels = viewModels
        self.router = router
    }
    
    // MARK: - DetailInfoPresenterInputProtocol methods
    func prevImageData() {
        if index == 0 {
            index = viewModels.count - 1
        } else if index >= 1 {
            index -= 1
        }
        let viewModel = viewModels[index]
        currentViewModel = viewModel
        view?.configureView(with: viewModel)
    }
    
    func nextImageData() {
        if index >= viewModels.count - 1 {
            index = 0
        } else if index < viewModels.count {
            index += 1
        }
        
        let viewModel = viewModels[index]
        currentViewModel = viewModel
        view?.configureView(with: viewModel)
    }
    
    func configureViewWithCurrentViewModel() {
        guard let imageDataViewModel = currentViewModel as? ImageDataViewModel else { return }
        index = imageDataViewModel.id - 1
        view?.configureView(with: currentViewModel)
    }
    
    func openImageDataInWebView() {
        guard let imageDataViewModel = currentViewModel as? ImageDataViewModel else { return }
        let imageUrlString = imageDataViewModel.sourceImageUrlString
        router.openWkWebView(with: imageUrlString)
    }
}
