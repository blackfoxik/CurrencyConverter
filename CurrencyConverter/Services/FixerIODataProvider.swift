//
//  FixerIOCAPI.swift
//  CurrencyConverter
//
//  Created by Anton on 31.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
struct FixerIODataProvider: CurrenciesDataProvider {
    
    func getRate(_ currencyFrom: Currency, _ currencyTo: Currency, completion: @escaping (Double?) -> Void) {
        let url = FixerIOURLMaker.getURL(for: currencyFrom.name)
        CurrencyHTTPTransport.getJson(from: url) { json in
            let rate = CurrencyJsonParser.JsonToRate(for: currencyTo.name, json: json)
            completion(rate)
        }
    }
    
    func getCurrenciesList(completion: @escaping ([Currency]) -> Void) {
        let url = FixerIOURLMaker.getURLForLatestRates()
        CurrencyHTTPTransport.getJson(from: url) { json in
            let currenciesList = CurrencyJsonParser.JsonToCurrenciesList(json: json)
            completion(currenciesList)
        }
    }
}

struct FixerIOURLMaker {
    
    static func getURL(for currencyCode: String) -> URL? {
        let url = URL(string: Keys.rootPath + Keys.latestPath + Keys.basePath + currencyCode)
        return url
    }
    
    static func getURLForLatestRates() -> URL? {
        let url = URL(string: Keys.rootPath + Keys.latestPath)
        return url
    }
}

struct CurrencyJsonParser {
    static func JsonToRate(for currencyToCode: String, json: Any) -> Double? {
        if let curData = json as? Dictionary<String, Any> {
            if let curRates = curData[Keys.ratesKey] as? Dictionary <String, Double> {
                let rate = curRates[currencyToCode]
                return rate
            }
        }
        return nil
    }
    
    static func JsonToCurrenciesList(json: Any) -> [Currency] {
        var currencies = [Currency]()
        if let curData = json as? Dictionary<String, Any> {
            let base = curData[Keys.baseKey] as? String
            let currency = Currency(name: base!)
            currencies.append(currency)
            if let curRates = curData[Keys.ratesKey] as? Dictionary <String, Double> {
                for curRate in curRates {
                    let currency = Currency(name: curRate.key)
                    currencies.append(currency)
                }
            }
        }
        return currencies
    }
}

struct CurrencyHTTPTransport {
    static func getJson(from url: URL?, completion: @escaping (Any) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                return
            }
            if data != nil {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) {
                    completion(json)
                }
            }
        }
        dataTask.resume()
    }
}

struct Keys {
    static let rootPath = "http://api.fixer.io/"
    static let latestPath = "latest"
    static let basePath = "?base="
    static let ratesKey = "rates"
    static let baseKey = "base"
}
