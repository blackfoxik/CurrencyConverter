//
//  CurrencyConverterViewObserverProtocol.swift
//  CurrencyConverter
//
//  Created by Anton on 02.11.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol CurrencyConverterViewObserver {
    func getCurrencyFromCount() -> Double?
    func getCurrencyToCount() -> Double?
    func getCurrencyFromName() -> String?
    func getCurrencyToName() -> String?
    func getCurrinciesList() -> [Currency]
    
    //all following stuff should be deleted after moving assembling presenter from ViewController to router
    var view: CurrencyConverterViewObservable? { get set }
    var currencyPair: CurrencyPair? {get set}
    func changeCurrencyFromCount(count: Double)
    func changeCurrencyToCount(count: Double)
    var currenciesList: [Currency] {get set}
}
