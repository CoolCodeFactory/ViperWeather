//
//  DetailListContainer.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


class DetailListContainer: AssemblyType {

    func assemble(container: Container) {
        container.registerForStoryboard(DetailListViewController.self) { (r, c) -> () in
            container.register(DetailListPresenterProtocol.self) { [weak c] r in
                guard let c = c else { fatalError("Contoller is nil") }

                let interface = c
                let interactor = r.resolve(DetailListInteractorInputProtocol.self)!
                let router = r.resolve(DetailListRouterInputProtocol.self)!
                
                let presenter = DetailListPresenter(interface: interface, interactor: interactor, router: router)
                interactor.presenter = presenter
                
                return presenter
            }
            c.presenter = r.resolve(DetailListPresenterProtocol.self)
        }
        
        container.register(DetailListInteractorInputProtocol.self) { r in
            let interactor = DetailListInteractor()
            interactor.dataManager = r.resolve(DetailListDataManagerInputProtocol.self)!
            return interactor
        }
        container.register(DetailListDataManagerOutputProtocol.self) { r in
            r.resolve(DetailListInteractorInputProtocol.self) as! DetailListDataManagerOutputProtocol
        }
        
        container.register(DetailListRouterInputProtocol.self) { (r) in
            let router = DetailListRouter()
            router.detailListDetailAssembler = r.resolve(DetailListDetailAssembler.self)!
            return router
        }
        
        container.register(DetailListDataManagerInputProtocol.self) { (r) in
            let dataManager = DetailListDataManager()
            return dataManager
        }
        
        container.register(DetailListDetailAssembler.self) { r in
            let parentAssembler = r.resolve(DetailListAssembler.self)!
            return DetailListDetailAssembler(parentAssembler: parentAssembler)
        }
    }
}
