//
//  Extension Optional + String.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import Foundation

extension Optional where Wrapped == String {
    
    var isEmptyOrNil: Bool {
        return self?.isEmpty != false
    }
}
