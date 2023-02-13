//
//  DetailInfoPresenterOutputProtocol.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

protocol DetailInfoPresenterOutputProtocol: AnyObject {
    func configureView(with viewModel: ViewModel)
}
