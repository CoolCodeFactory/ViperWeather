//
//  ListPresenter.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import Swinject


protocol ListPresenterProtocol: class {
    
    func showDetailCity(city: City)
    func addNew()
    func exit()
    func removeCity(city: City)
}

protocol ListInterfaceProtocol: class {
    
    var presenter: ListPresenterProtocol!  { get set }
}

class ListPresenter {
    
    weak private var interface: ListInterfaceProtocol!
    private let interactor: ListInteractorInputProtocol
    private let router: ListRouterInputProtocol
    
    
    init(interface: ListInterfaceProtocol, interactor: ListInteractorInputProtocol, router: ListRouterInputProtocol) {
        self.interface = interface
        self.interactor = interactor
        self.router = router
    }
    
}


extension ListPresenter: ListPresenterProtocol {
    
    func showDetailCity(city: City) {
        self.router.presentDetailViewController(fromViewController: self.interface as! UIViewController, city: city)
    }
    
    func removeCity(city: City) {
        self.interactor.removeCity(city)
    }
    
    func addNew() {
        self.router.presentAddViewController(fromViewController: self.interface as! UIViewController)
    }
    
    func exit() {
        self.router.dismissListViewController(viewController: self.interface as! UIViewController)
    }
}

extension ListPresenter: ListInteractorOutputProtocol {
    
}

