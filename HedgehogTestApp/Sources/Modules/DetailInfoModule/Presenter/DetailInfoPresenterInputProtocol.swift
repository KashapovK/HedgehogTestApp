//
//  DetailInfoPresenterInputProtocol.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

protocol DetailInfoPresenterInputProtocol {
    func prevImageData()
    func nextImageData()
    func configureViewWithCurrentViewModel()
    func openImageDataInWebView()
}
