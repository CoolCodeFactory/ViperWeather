//
//  DetailContainerRouter.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


protocol DetailContainerRouterInputProtocol: class {
    func dismissDetailContainerViewController(viewController viewController: UIViewController)

    func presentDetailViewController(viewController viewController: UIViewController, view: UIView, city: City)
    func presentDetailListViewController(viewController viewController: UIViewController, view: UIView, city: City)
    
    var detailAssembler: DetailAssembler! { get set }
    var detailListAssembler: DetailListAssembler! { get set }
}

protocol DetailContainerParentRouterProtocol: class {
    
}

class DetailContainerRouter: DetailContainerRouterInputProtocol {
    
    var detailAssembler: DetailAssembler!
    var detailListAssembler: DetailListAssembler!

    
    func dismissDetailContainerViewController(viewController viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentDetailViewController(viewController viewController: UIViewController, view: UIView, city: City) {
        detailAssembler.presentDetailViewController(fromViewController: viewController, inView: view, city: city)
    }
    
    func presentDetailListViewController(viewController viewController: UIViewController,  view: UIView, city: City) {
        detailListAssembler.presentDetailListViewController(fromViewController: viewController, inView: view, city: city)
    }
}
