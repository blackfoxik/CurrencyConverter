//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Anton on 26.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    var presenter: CurrencyConverterViewObserver?
    @IBOutlet weak var currencyFromLabel: UILabel!
    @IBOutlet weak var currencyToLabel: UILabel!
    @IBOutlet weak var currencyFromCountTextField: UITextField!
    @IBOutlet weak var currencyToCountTextField: UITextField!
    @IBOutlet weak var currencyFromButton: UIButton!
    @IBOutlet weak var currencyToButton: UIButton!
    
    @IBAction func changeCurrencyFromCount(_ sender: UITextField) {
        let count = Double(sender.text!) ?? DefaultKeys.DEFAULT_COUNT
        presenter?.changeCurrencyFromCount(count: count)
    }
    @IBAction func changeCurrencyToCount(_ sender: UITextField) {
        let count = Double(sender.text!) ?? DefaultKeys.DEFAULT_COUNT
        presenter?.changeCurrencyToCount(count: count)
    }
    
    @IBAction func selectCurrencyFrom(_ sender: UIButton) {
        selectCurrency(isSelectionCurrencyFrom: true)
    }
    
    @IBAction func selectCurrencyTo(_ sender: UIButton) {
        selectCurrency(isSelectionCurrencyFrom: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyFromCountTextField.delegate = self
        currencyToCountTextField.delegate = self
        setupPresenter()
    }

}

extension CurrencyConverterViewController {
    private func setupPresenter() {
        presenter = ServiceLocator.resolve(presenterType: .CurrencyConverterViewPresenter) as? CurrencyConverterViewObserver
        presenter?.view = self
        updateUI()        
    }
}

extension CurrencyConverterViewController {
    private func selectCurrency(isSelectionCurrencyFrom: Bool) {
        let currinciesList = presenter?.getCurrinciesList()
        if currinciesList != nil, currinciesList!.count > 0 {
        let currencySelectorTableViewController = CurrencySelectorTableViewController.instantiate(fromAppStoryboard: .Main)
            currencySelectorTableViewController?.presenter = presenter as? CurrencySelectorViewObserver
            currencySelectorTableViewController?.currencies = currinciesList!
            currencySelectorTableViewController?.isSelectionCurrencyFrom = isSelectionCurrencyFrom
            self.present(currencySelectorTableViewController!, animated: true)
        }
    }
}

extension CurrencyConverterViewController: CurrencyConverterViewObservable {
    func updateUI() {
        DispatchQueue.main.async {
            let currencyFromCount = self.presenter?.getCurrencyFromCount() ?? DefaultKeys.DEFAULT_COUNT
            let currencyFromCountString = self.zeroDotZeroToZero(original: String(currencyFromCount))
            let currencyToCount = self.presenter?.getCurrencyToCount() ?? DefaultKeys.DEFAULT_COUNT
            let currencyToCountString = self.zeroDotZeroToZero(original: String(currencyToCount))
            let currencyFromString = self.presenter?.getCurrencyFromName() ?? DefaultKeys.DEFAULT_LABEL_FOR_CURRENCY_FROM_BUTTON
            let currencyToString = self.presenter?.getCurrencyToName() ?? DefaultKeys.DEFAULT_LABEL_FOR_CURRENCY_TO_BUTTON
            
            self.currencyFromLabel.text = "\(currencyFromCountString) \(currencyFromString) equals"
            self.currencyToLabel.text = "\(currencyToCountString) \(currencyToString)"
            self.currencyFromCountTextField.text = currencyFromCountString
            self.currencyToCountTextField.text = currencyToCountString
            self.currencyFromButton.setTitle(currencyFromString, for: .normal)
            self.currencyToButton.setTitle(currencyToString, for: .normal)
        }
    }
    //durty code should be replaced with smth more elegant
    private func zeroDotZeroToZero(original: String) -> String {
        if original == "0.0" {
            return "0"
        }
        return original
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

struct DefaultKeys {
    static let DEFAULT_COUNT: Double = 0
    static let DEFAULT_CURRENCY_FROM_NUMBER: Int = 0
    static let DEFAULT_CURRENCY_TO_NUMBER: Int = 1
    static let DEFAULT_LABEL_FOR_CURRENCY_FROM_BUTTON: String = "From"
    static let DEFAULT_LABEL_FOR_CURRENCY_TO_BUTTON: String = "To"
}

