//
//  DetailContainerPresenter.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


protocol DetailContainerPresenterProtocol: class {
    
    func presentDetailViewControllerInView(view: UIView, city: City)
    func presentDetailListViewControllerInView(view: UIView, city: City)
}

protocol DetailContainerInterfaceProtocol: class {
    
    var presenter: DetailContainerPresenterProtocol!  { get set }
}

class DetailContainerPresenter {
    
    weak private var interface: DetailContainerInterfaceProtocol!
    private let interactor: DetailContainerInteractorInputProtocol
    private let router: DetailContainerRouterInputProtocol
    
    
    init(interface: DetailContainerInterfaceProtocol, interactor: DetailContainerInteractorInputProtocol, router: DetailContainerRouterInputProtocol) {
        self.interface = interface
        self.interactor = interactor
        self.router = router
    }
}


extension DetailContainerPresenter: DetailContainerPresenterProtocol {
    
    func presentDetailViewControllerInView(view: UIView, city: City) {
        self.router.presentDetailViewController(viewController: self.interface as! UIViewController, view: view, city: city)
    }
    
    func presentDetailListViewControllerInView(view: UIView, city: City) {
        self.router.presentDetailListViewController(viewController: self.interface as! UIViewController, view: view, city: city)
    }
}

extension DetailContainerPresenter: DetailContainerInteractorOutputProtocol {
    
}

