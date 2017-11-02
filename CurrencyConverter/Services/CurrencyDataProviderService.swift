//
//  CurrencyDataProviderService.swift
//  CurrencyConverter
//
//  Created by Anton on 01.11.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
struct CurrencyDataProviderService: CurrenciesDataProviderService {
    var dataProvider: CurrenciesDataProvider
    
    init (dataProvider: CurrenciesDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func getRate(_ currencyFrom: Currency, _ currencyTo: Currency, completion: @escaping (Double?) -> Void) {
        dataProvider.getRate(currencyFrom, currencyTo, completion: completion)
    }
    
    func getCurrenciesList(completion: @escaping ([Currency]) -> Void) {
        dataProvider.getCurrenciesList(completion: completion)
    }
}

