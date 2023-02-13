//
//  DetailViewConfigurableProtocol.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 11.02.2023.
//

import UIKit

protocol DetailViewConfigurableProtocol where Self: UIView {
    func configureView(with viewModel: ViewModel)
}
