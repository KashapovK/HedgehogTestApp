//
//  MainSearchPresenterInputProtocol.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

protocol MainSearchPresenterInputProtocol {
    func getDataFromNet(with query: String)
    func emptyDataResult()
    func pushToDetailInfoViewController(with currentViewModel: ViewModel, viewModels: [ViewModel])
}
