//
//  ChildPresenter.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


protocol ChildPresenterProtocol: class {
    
}

protocol ChildInterfaceProtocol: class {
    
    var presenter: ChildPresenterProtocol!  { get set }
}

class ChildPresenter {
    
    weak private var interface: ChildInterfaceProtocol!
    private let interactor: ChildInteractorInputProtocol
    private let router: ChildRouterInputProtocol
    
    
    init(interface: ChildInterfaceProtocol, interactor: ChildInteractorInputProtocol, router: ChildRouterInputProtocol) {
        self.interface = interface
        self.interactor = interactor
        self.router = router
    }
    
}


extension ChildPresenter: ChildPresenterProtocol {
    
}

extension ChildPresenter: ChildInteractorOutputProtocol {
    
}

