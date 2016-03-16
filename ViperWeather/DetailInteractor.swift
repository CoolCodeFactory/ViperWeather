//
//  DetailInteractor.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import Foundation


protocol DetailInteractorInputProtocol: class {
    
    weak var presenter: DetailInteractorOutputProtocol! { get set }
    
    func getDetailCity(city: City)
    func getWeatherForCity(city: City)
}

protocol DetailInteractorOutputProtocol: class {
    
    func foundDetailCity(city: City)
    func foundWeatherForCity(weather: [Weather], city: City)
}

class DetailInteractor {
    
    weak var presenter: DetailInteractorOutputProtocol!
    
    var dataManager: DetailDataManagerInputProtocol!

}

extension DetailInteractor: DetailInteractorInputProtocol {

    func getDetailCity(city: City) {
        self.dataManager.getDetailCity(city) { [weak self] (city) -> () in
            self?.dataManager.updateCityInPersistentStore(city)
            self?.presenter.foundDetailCity(city)
        }
    }
    
    func getWeatherForCity(city: City) {
        self.dataManager.getWeatherForCity(city) { [weak self] (weather) -> () in
            self?.presenter.foundWeatherForCity(weather, city: city)
        }
    }
    
}

extension DetailInteractor: DetailDataManagerOutputProtocol {
    
}