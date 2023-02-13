//
//  CollectionViewCellConfigurableProtocol.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 11.02.2023.
//

import UIKit

protocol CollectionViewCellConfigurableProtocol where Self: UICollectionViewCell {
    func configure(with viewModel: ViewModel)
}
