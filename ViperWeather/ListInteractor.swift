//
//  ListInteractor.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import Foundation


protocol ListInteractorInputProtocol: class {
    
    weak var presenter: ListInteractorOutputProtocol! { get set }
    
    func removeCity(city: City)
    func updateWeather()
}

protocol ListInteractorOutputProtocol: class {

}

class ListInteractor {
    
    weak var presenter: ListInteractorOutputProtocol!
    
    var dataManager: ListDataManagerInputProtocol!
}

extension ListInteractor: ListInteractorInputProtocol {
    
    func removeCity(city: City) {
        dataManager.removeCityFromPersistentStore(city)
    }
    
    func updateWeather() {
        self.dataManager.updateWeather()
    }
    
}

extension ListInteractor: ListDataManagerOutputProtocol {
    
}