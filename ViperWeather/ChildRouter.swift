//
//  ChildRouter.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


protocol ChildRouterInputProtocol: class {
    func dismissChildViewController(viewController viewController: UIViewController)
}

protocol ChildParentRouterProtocol: class {
    
}

class ChildRouter: ChildRouterInputProtocol {
    
    func dismissChildViewController(viewController viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
