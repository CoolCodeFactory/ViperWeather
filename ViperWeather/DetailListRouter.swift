//
//  DetailListRouter.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


protocol DetailListRouterInputProtocol: class {
    func dismissDetailListViewController(viewController viewController: UIViewController)
    func presentDetailListDetailViewController(fromViewController fromViewController: UIViewController)
    
    var detailListDetailAssembler: DetailListDetailAssembler! { get set }
}

protocol DetailListParentRouterProtocol: class {
    
}

class DetailListRouter: DetailListRouterInputProtocol {
    
    var detailListDetailAssembler: DetailListDetailAssembler!

    
    func dismissDetailListViewController(viewController viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentDetailListDetailViewController(fromViewController fromViewController: UIViewController) {
        detailListDetailAssembler.presentDetailListDetailViewController(fromViewController: fromViewController)
    }
}
