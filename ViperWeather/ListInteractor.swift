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
    
    func getCities()
    func removeCity(city: City)
}

protocol ListInteractorOutputProtocol: class {
    
    func foundCities(cities: [City])
}

class ListInteractor {
    
    weak var presenter: ListInteractorOutputProtocol!
    
    var dataManager: ListDataManagerInputProtocol!
}

extension ListInteractor: ListInteractorInputProtocol {
    
    func getCities() {
        dataManager.fetchCitiesFromPersistentStore { [weak self] (cities) -> () in
            self?.presenter.foundCities(cities)
        }
    }
    
    func removeCity(city: City) {
        dataManager.removeCityFromPersistentStore(city)
        getCities()
    }
}

extension ListInteractor: ListDataManagerOutputProtocol {
    
}