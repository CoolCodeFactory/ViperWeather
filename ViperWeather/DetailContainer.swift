//
//  DetailContainer.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import Swinject


class DetailContainer: AssemblyType {

    func assemble(container: Container) {
        container.registerForStoryboard(DetailViewController.self) { (r, c) -> () in
            container.register(DetailPresenterProtocol.self) { [weak c] r in
                guard let c = c else { fatalError("Contoller is nil") }

                let interface = c
                let interactor = r.resolve(DetailInteractorInputProtocol.self)!
                let router = r.resolve(DetailRouterInputProtocol.self)!
                
                let presenter = DetailPresenter(interface: interface, interactor: interactor, router: router)
                interactor.presenter = presenter
                
                return presenter
            }
            c.presenter = r.resolve(DetailPresenterProtocol.self)
        }
        
        container.register(DetailInteractorInputProtocol.self) { r in
            let interactor = DetailInteractor()
            let dataManager = r.resolve(DetailDataManagerInputProtocol.self)!
            interactor.dataManager = dataManager
            dataManager.interactor = interactor
            return interactor
        }
        
        container.register(DetailRouterInputProtocol.self) { (r) in
            let router = DetailRouter()
            return router
        }
        
        container.register(DetailDataManagerInputProtocol.self) { (r) in
            let dataManager = DetailDataManager()
            return dataManager
        }
    }
}
