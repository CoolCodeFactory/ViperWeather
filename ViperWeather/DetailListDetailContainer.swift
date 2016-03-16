//
//  DetailListDetailContainer.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


class DetailListDetailContainer: AssemblyType {

    func assemble(container: Container) {
        container.registerForStoryboard(DetailListDetailViewController.self) { (r, c) -> () in
            container.register(DetailListDetailPresenterProtocol.self) { [weak c] r in
                guard let c = c else { fatalError("ViewController is nil") }

                let interface = c
                let interactor = r.resolve(DetailListDetailInteractorInputProtocol.self)!
                let router = r.resolve(DetailListDetailRouterInputProtocol.self)!
                
                let presenter = DetailListDetailPresenter(interface: interface, interactor: interactor, router: router)
                interactor.presenter = presenter
                
                return presenter
            }
            c.presenter = r.resolve(DetailListDetailPresenterProtocol.self)
        }
        
        container.register(DetailListDetailInteractorInputProtocol.self) { r in
            let interactor = DetailListDetailInteractor()
            let dataManager = r.resolve(DetailListDetailDataManagerInputProtocol.self)!
            interactor.dataManager = dataManager
            dataManager.interactor = interactor
            return interactor
        }
        
        container.register(DetailListDetailRouterInputProtocol.self) { (r) in
            let router = DetailListDetailRouter()
            router.childAssembler = r.resolve(ChildAssembler.self)!
            return router
        }
        
        container.register(DetailListDetailDataManagerInputProtocol.self) { (r) in
            let dataManager = DetailListDetailDataManager()
            return dataManager
        }

        
        container.register(ChildAssembler.self) { r in
            let parentAssembler = r.resolve(DetailListDetailAssembler.self)!
            return ChildAssembler(parentAssembler: parentAssembler)
        }
    }
}
