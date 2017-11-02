//
//  CurrencySelectorTableViewController.swift
//  CurrencyConverter
//
//  Created by Anton on 01.11.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class CurrencySelectorTableViewController: UITableViewController {
    
    var currencies = [Currency]()
    var presenter: CurrencySelectorViewObserver?
    var isSelectionCurrencyFrom: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return DefaultKeys.DEFAULT_COUNT_OF_SECTION
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        cell.textLabel?.text = currencies[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        if isSelectionCurrencyFrom {
            presenter?.selectedCurrencyFrom(currency: currency)
        } else {
            presenter?.selectedCurrencyTo(currency: currency)
        }
        self.dismiss(animated: true) 
    }
}

extension DefaultKeys {
    static let DEFAULT_COUNT_OF_SECTION: Int = 1
}


