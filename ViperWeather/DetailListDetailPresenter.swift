//
//  DetailListDetailPresenter.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


protocol DetailListDetailPresenterProtocol: class {
    func presentChildViewController()
}

protocol DetailListDetailInterfaceProtocol: class {
    
    var presenter: DetailListDetailPresenterProtocol!  { get set }
}

class DetailListDetailPresenter {
    
    weak private var interface: DetailListDetailInterfaceProtocol!
    private let interactor: DetailListDetailInteractorInputProtocol
    private let router: DetailListDetailRouterInputProtocol
    
    
    init(interface: DetailListDetailInterfaceProtocol, interactor: DetailListDetailInteractorInputProtocol, router: DetailListDetailRouterInputProtocol) {
        self.interface = interface
        self.interactor = interactor
        self.router = router
    }
    
}


extension DetailListDetailPresenter: DetailListDetailPresenterProtocol {
    
    func presentChildViewController() {
        self.router.presentChildViewController(fromViewController: self.interface as! UIViewController)
    }
}

extension DetailListDetailPresenter: DetailListDetailInteractorOutputProtocol {
    
}

