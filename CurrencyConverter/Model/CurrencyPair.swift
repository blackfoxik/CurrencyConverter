//
//  CurrencyPair.swift
//  CurrencyConverter
//
//  Created by Anton on 30.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

class CurrencyPair {
    var currencyFrom: Currency? {
        didSet {
            setRate()
        }
    }
    var currencyTo: Currency? {
        didSet {
            setRate()
        }
    }
    var rate: Double?
    let dataProviderService: CurrenciesDataProviderService
    var presenter: CurrencyPairModelObserver
    init(currencyFrom: Currency, currencyTo: Currency, dataProviderService: CurrenciesDataProviderService, presenter: CurrencyPairModelObserver) {
        self.currencyFrom = currencyFrom
        self.currencyTo = currencyTo
        self.dataProviderService = dataProviderService
        self.presenter = presenter
        setRate()
    }
    
    private func setRate() {
        if self.currencyTo != nil && self.currencyFrom != nil {
            if self.currencyTo! != self.currencyFrom! {
                dataProviderService.getRate(self.currencyFrom!, self.currencyTo!) { rate in
                    self.rate = rate
                    self.presenter.rateWasChanged()
                }
            } else {
                self.rate = DefaultKeys.DEFAULT_RATE_FOR_THE_SAME_CURRINCIES
                self.presenter.rateWasChanged()
            }
        }
    }
}

extension DefaultKeys {
    static let DEFAULT_RATE_FOR_THE_SAME_CURRINCIES:Double = 1
}

