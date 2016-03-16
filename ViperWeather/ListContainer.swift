//
//  ListContainer.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import Swinject


class ListContainer: AssemblyType {

    func assemble(container: Container) {
        container.registerForStoryboard(ListTableViewController.self) { (r, c) -> () in
            container.register(ListPresenterProtocol.self) { [weak c] r in
                guard let c = c else { fatalError("Contoller is nil") }
                
                let interface = c
                let interactor = r.resolve(ListInteractorInputProtocol.self)!
                let router = r.resolve(ListRouterInputProtocol.self)!
                
                let presenter = ListPresenter(interface: interface, interactor: interactor, router: router)
                interactor.presenter = presenter
                
                return presenter
            }
            c.presenter = r.resolve(ListPresenterProtocol.self)
        }
        
        container.register(ListInteractorInputProtocol.self) { r in
            let interactor = ListInteractor()
            let dataManager = r.resolve(ListDataManagerInputProtocol.self)!
            interactor.dataManager = dataManager
            dataManager.interactor = interactor
            return interactor
        }
        
        container.register(ListRouterInputProtocol.self) { (r) in
            let router = ListRouter()
            router.addAssembler = r.resolve(AddAssembler.self)!
            router.detailContainerAssembler = r.resolve(DetailContainerAssembler.self)!
            return router
        }
        
        container.register(ListDataManagerInputProtocol.self) { (r) in
            let dataManager = ListDataManager()
            return dataManager
        }
        
        container.register(AddAssembler.self) { r in
            let parentAssembler = r.resolve(ListAssembler.self)!
            return AddAssembler(parentAssembler: parentAssembler)
        }
        container.register(DetailContainerAssembler.self) { r in
            let parentAssembler = r.resolve(ListAssembler.self)!
            return DetailContainerAssembler(parentAssembler: parentAssembler)
        }
    }
}
