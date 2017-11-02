//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Anton on 26.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import XCTest
@testable import CurrencyConverter


class CurrencyConverterTests: XCTestCase {
    var currencyPair: CurrencyPair!
    let eur = Currency(name: "EUR")
    let usd = Currency(name: "USD")
    
    override func setUp() {
        super.setUp()
        let dataProvider = FixerIODataProvider()
        let dataProviderService = CurrencyDataProviderService(dataProvider: dataProvider)
        let presenter = CurrencyConverterPresenter()
        currencyPair = CurrencyPair(currencyFrom: eur, currencyTo: eur, dataProviderService: dataProviderService, presenter: presenter)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        currencyPair = nil
    }
    
    func testCurrencyPairEqualCurrencies() {
        currencyPair.currencyFrom = usd
        currencyPair.currencyTo = usd
        XCTAssertEqual(currencyPair.rate!, 1, "Rate is wrong")
    }
    
    func testDataProviderWithDifferentCurrencies() {
        let exp = expectation(description: "rate for different currincies")
        let dataProvider = FixerIODataProvider()
        dataProvider.getRate(usd, eur) { rate in
            XCTAssertNotEqual(rate!, 1, "Rate is wrong")
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    
}
