//
//  DetailListInteractor.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import Foundation


protocol DetailListInteractorInputProtocol: class {
    
    weak var presenter: DetailListInteractorOutputProtocol! { get set }
    
    func getDetailCity(city: City)
    func getWeatherForCity(city: City)
}

protocol DetailListInteractorOutputProtocol: class {
    
    func foundDetailCity(city: City)
    func foundWeatherForCity(weather: [Weather], city: City)
}

class DetailListInteractor {
    
    weak var presenter: DetailListInteractorOutputProtocol!
    
    var dataManager: DetailListDataManagerInputProtocol!
    
}

extension DetailListInteractor: DetailListInteractorInputProtocol {

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

extension DetailListInteractor: DetailListDataManagerOutputProtocol {
    
}