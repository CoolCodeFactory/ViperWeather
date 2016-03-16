//
//  DetailRouter.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import Swinject


protocol DetailRouterInputProtocol: class {
    func dismissDetailViewController(viewController viewController: UIViewController)
}

protocol DetailParentRouterProtocol: class {
    
}

class DetailRouter: DetailRouterInputProtocol {
    
    func dismissDetailViewController(viewController viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
