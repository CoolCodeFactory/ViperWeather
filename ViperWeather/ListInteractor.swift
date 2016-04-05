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
        self.dataManager.fetchCitiesFromPersistentStore { (cities) in
            for (index, city) in cities.enumerate() {
                let delay = (Double(index) * 0.7) * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    // Workaround error 429: Too many requests
                    
                    if city.isLocationEnable() {
                        self.dataManager.getWeatherForCity(city, callback: { [weak self] (weather) in
                            if let weather = weather {
                                self?.dataManager.updateCityInPersistentStore(city, weather: weather)
                            }
                        })
                    } else {
                        self.dataManager.getDetailCity(city, callback: { [weak self] (lat, lng) in
                            let city = self?.dataManager.updateCityInPersistentStore(city, lat: lat, lng: lng)
                            if let city = city {
                                self?.dataManager.getWeatherForCity(city, callback: { [weak self] (weather) in
                                    if let weather = weather {
                                        self?.dataManager.updateCityInPersistentStore(city, weather: weather)
                                    }
                                })
                            }
                        })
                    }
                }
            }
        }
    }
    
}

extension ListInteractor: ListDataManagerOutputProtocol {
    
}
