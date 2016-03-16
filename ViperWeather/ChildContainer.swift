//
//  ChildContainer.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


class ChildContainer: AssemblyType {

    func assemble(container: Container) {
        container.registerForStoryboard(ChildViewController.self) { (r, c) -> () in
            container.register(ChildPresenterProtocol.self) { [weak c] r in
                guard let c = c else { fatalError("ViewController is nil") }

                let interface = c
                let interactor = r.resolve(ChildInteractorInputProtocol.self)!
                let router = r.resolve(ChildRouterInputProtocol.self)!
                
                let presenter = ChildPresenter(interface: interface, interactor: interactor, router: router)
                interactor.presenter = presenter
                
                return presenter
            }
            c.presenter = r.resolve(ChildPresenterProtocol.self)
        }
        
        container.register(ChildInteractorInputProtocol.self) { r in
            let interactor = ChildInteractor()
            let dataManager = r.resolve(ChildDataManagerInputProtocol.self)!
            interactor.dataManager = dataManager
            dataManager.interactor = interactor
            return interactor
        }
        
        container.register(ChildRouterInputProtocol.self) { (r) in
            let router = ChildRouter()
            return router
        }
        
        container.register(ChildDataManagerInputProtocol.self) { (r) in
            let dataManager = ChildDataManager()
            return dataManager
        }

        
    }
}
