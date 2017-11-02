//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Anton on 31.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
class CurrencyConverterPresenter {
    var view: CurrencyConverterViewObservable?
    var currencyPair: CurrencyPair?
    var currencyFromCount: Double?
    var currencyToCount: Double?
    var currenciesList = [Currency]()
}

extension CurrencyConverterPresenter:  CurrencyConverterViewObserver {
    func getCurrinciesList() -> [Currency] {
        return currenciesList
    }
    
    func getCurrencyFromCount() -> Double? {
        return currencyFromCount
    }
    
    func getCurrencyToCount() -> Double? {
        return currencyToCount 
    }
    
    func getCurrencyFromName() -> String? {
        return currencyPair?.currencyFrom?.name
    }
    
    func getCurrencyToName() -> String? {
        return currencyPair?.currencyTo?.name
    }
    
    func changeCurrencyFromCount(count: Double) {
        currencyFromCount = count
        let toCount = (currencyPair?.rate)! * count
        currencyToCount = toCount
        view?.updateUI()
    }
    
    func changeCurrencyToCount(count: Double) {
        currencyToCount = count
        let fromCount = count / (currencyPair?.rate)!
        currencyFromCount = fromCount
        view?.updateUI()
    }
}

extension CurrencyConverterPresenter: CurrencySelectorViewObserver {
    func selectedCurrencyFrom(currency: Currency) {
        currencyPair?.currencyFrom = currency
    }
    
    func selectedCurrencyTo(currency: Currency) {
        currencyPair?.currencyTo = currency
    }
}

extension CurrencyConverterPresenter: CurrencyPairModelObserver {
    func rateWasChanged() {
        currencyToCount = (currencyPair?.rate ?? DefaultKeys.DEFAULT_COUNT) * (currencyFromCount ?? DefaultKeys.DEFAULT_COUNT)
        view?.updateUI()
    }
}


