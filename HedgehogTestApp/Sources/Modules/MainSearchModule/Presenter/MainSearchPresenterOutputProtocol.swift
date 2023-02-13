//
//  MainSearchPresenterOutputProtocol.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

protocol MainSearchPresenterOutputProtocol: AnyObject {
    func configureView(with viewModel: [ViewModel])
    func configureAlert(with error: NetworkError)
    func didSelectImage(with currentViewModel: ViewModel)
}
