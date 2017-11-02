//
//  CurrenciesDataProviderServiceProtocol.swift
//  CurrencyConverter
//
//  Created by Anton on 02.11.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

protocol  CurrenciesDataProviderService: CurrenciesDataProvider {
    var dataProvider: CurrenciesDataProvider { get set }
}
