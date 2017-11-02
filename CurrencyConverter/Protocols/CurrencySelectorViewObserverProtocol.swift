//
//  CurrencySelectorViewObserverProtocol.swift
//  CurrencyConverter
//
//  Created by Anton on 02.11.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol CurrencySelectorViewObserver {
    func selectedCurrencyFrom(currency: Currency)
    func selectedCurrencyTo(currency: Currency)
}
