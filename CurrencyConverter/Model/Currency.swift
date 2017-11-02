//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Anton on 30.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

class Currency {
    let name: String
    init (name: String) {
        self.name = name
    }
}

extension Currency: Equatable {
    static func ==(lhs: Currency, rhs: Currency) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    static func !=(lhs: Currency, rhs: Currency) -> Bool {
        return !(lhs.hashValue == rhs.hashValue)
    }
}

extension Currency: Hashable {
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}
