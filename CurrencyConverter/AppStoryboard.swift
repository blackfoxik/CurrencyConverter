//
//  AppStoryboard.swift
//  CurrencyConverter
//
//  Created by Anton on 02.11.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    case Main
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController> (viewControllerClass: T.Type) -> T? {
        return self.instance.instantiateViewController(withIdentifier: viewControllerClass.storyboardID) as? T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self? {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
