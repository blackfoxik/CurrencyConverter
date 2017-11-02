//
//  CurrenciesDataProvider.swift
//  CurrencyConverter
//
//  Created by Anton on 31.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

protocol CurrenciesDataProvider {
    func getRate(_ currencyFrom: Currency, _ currencyTo: Currency, completion: @escaping (Double?) -> Void)
    func getCurrenciesList(completion: @escaping ([Currency]) -> Void)
}

