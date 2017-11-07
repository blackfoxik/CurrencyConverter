//
//  ServiceLocator.swift
//  CurrencyConverter
//
//  Created by Anton on 08.11.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

class ServiceLocator {
    static func resolve(presenterType: PresenterTypeEnum) -> Any? {
        switch presenterType {
        case .CurrencyConverterViewPresenter:
            return createCurrencyConverterViewPresenter()
        default:
            return nil
        }
    }
}

extension ServiceLocator {
    private static func createCurrencyConverterViewPresenter() -> CurrencyConverterViewObserver? {
        let presenter: CurrencyConverterPresenter? = CurrencyConverterPresenter()
        let fixerIOdataProvider = FixerIODataProvider()
        let dataProviderService = CurrencyDataProviderService(dataProvider: fixerIOdataProvider)
        _ = dataProviderService.getCurrenciesList() { currenciesList in
            
            presenter?.currenciesList = currenciesList
            let currencyPair = CurrencyPair(currencyFrom: currenciesList[DefaultKeys.DEFAULT_CURRENCY_FROM_NUMBER],
                                            currencyTo: currenciesList[DefaultKeys.DEFAULT_CURRENCY_TO_NUMBER],
                                            dataProviderService: dataProviderService,
                                            presenter: presenter as! CurrencyPairModelObserver)
            presenter?.currencyPair = currencyPair
        }
        return presenter
    }
}

enum PresenterTypeEnum {
    case CurrencyConverterViewPresenter
}
