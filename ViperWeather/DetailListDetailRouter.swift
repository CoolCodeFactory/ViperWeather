//
//  DetailListDetailRouter.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


protocol DetailListDetailRouterInputProtocol: class {
    func dismissDetailListDetailViewController(viewController viewController: UIViewController)
    func presentChildViewController(fromViewController fromViewController: UIViewController)

    var childAssembler: ChildAssembler! { get set }
}

protocol DetailListDetailParentRouterProtocol: class {
    
}

class DetailListDetailRouter: DetailListDetailRouterInputProtocol {
    
    var childAssembler: ChildAssembler!
    
    
    func dismissDetailListDetailViewController(viewController viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentChildViewController(fromViewController fromViewController: UIViewController) {
        childAssembler.presentChildViewController(fromViewController: fromViewController)
    }
}
