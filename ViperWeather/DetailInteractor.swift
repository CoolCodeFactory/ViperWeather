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
    
    func getWeatherForCity(city: City)
}

protocol DetailInteractorOutputProtocol: class {
    
    func updateCity(city: City?)
}

class DetailInteractor {
    
    weak var presenter: DetailInteractorOutputProtocol!
    
    var dataManager: DetailDataManagerInputProtocol!

}

extension DetailInteractor: DetailInteractorInputProtocol {
    
    func getWeatherForCity(city: City) {
        if city.isLocationEnable() {
            self.dataManager.getWeatherForCity(city) { [weak self] (weather) -> () in
                if let weather = weather {
                    let city = self?.dataManager.updateCityInPersistentStore(city, weather: weather)
                    self?.presenter.updateCity(city)
                } else {
                    self?.presenter.updateCity(city)
                }
            }
        } else {
            self.dataManager.getDetailCity(city) { [weak self] (lat, lng) in
                let city = self?.dataManager.updateCityInPersistentStore(city, lat: lat, lng: lng)
                if let city = city {
                    self?.dataManager.getWeatherForCity(city) { [weak self] (weather) -> () in
                        if let weather = weather {
                            let city = self?.dataManager.updateCityInPersistentStore(city, weather: weather)
                            self?.presenter.updateCity(city)
                        } else {
                            self?.presenter.updateCity(city)
                        }
                    }
                }
            }
        }
    }
}

extension DetailInteractor: DetailDataManagerOutputProtocol {
    
}