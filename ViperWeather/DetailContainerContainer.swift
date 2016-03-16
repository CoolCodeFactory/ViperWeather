//
//  DetailContainerContainer.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


class DetailContainerContainer: AssemblyType {

    func assemble(container: Container) {
        container.registerForStoryboard(DetailContainerViewController.self) { (r, c) -> () in
            container.register(DetailContainerPresenterProtocol.self) { [weak c] r in
                guard let c = c else { fatalError("Contoller is nil") }
                                
                let interface = c
                let interactor = r.resolve(DetailContainerInteractorInputProtocol.self)!
                let router = r.resolve(DetailContainerRouterInputProtocol.self)!
                
                let presenter = DetailContainerPresenter(interface: interface, interactor: interactor, router: router)
                interactor.presenter = presenter
                
                return presenter
            }
            c.presenter = r.resolve(DetailContainerPresenterProtocol.self)
        }
        
        container.register(DetailContainerInteractorInputProtocol.self) { r in
            let interactor = DetailContainerInteractor()
            let dataManager = r.resolve(DetailContainerDataManagerInputProtocol.self)!
            interactor.dataManager = dataManager
            dataManager.interactor = interactor
            return interactor
        }
        
        container.register(DetailContainerRouterInputProtocol.self) { (r) in
            let router = DetailContainerRouter()
            router.detailAssembler = r.resolve(DetailAssembler.self)!
            router.detailListAssembler = r.resolve(DetailListAssembler.self)!
            return router
        }
        
        container.register(DetailContainerDataManagerInputProtocol.self) { (r) in
            let dataManager = DetailContainerDataManager()
            return dataManager
        }
        
        container.register(DetailAssembler.self) { r in
            let parentAssembler = r.resolve(DetailContainerAssembler.self)!
            return DetailAssembler(parentAssembler: parentAssembler)
        }
        container.register(DetailListAssembler.self) { r in
            let parentAssembler = r.resolve(DetailContainerAssembler.self)!
            return DetailListAssembler(parentAssembler: parentAssembler)
        }
    }
}
