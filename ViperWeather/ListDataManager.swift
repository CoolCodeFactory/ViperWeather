//
//  ListDataManager.swift
//  ViperWeather
//
//  Created by Dmitri Utmanov on 02/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire


protocol ListDataManagerInputProtocol: class {
    
    weak var interactor: ListDataManagerOutputProtocol! { get set }
    
    func fetchCitiesFromPersistentStore(callback: ([City]) -> ())
    func removeCityFromPersistentStore(city: City)
    func updateWeather()
}

protocol ListDataManagerOutputProtocol: class {
    
    var dataManager: ListDataManagerInputProtocol! { get set }
}


class ListDataManager {
    
    weak var interactor: ListDataManagerOutputProtocol!
}

extension ListDataManager: ListDataManagerInputProtocol {
    
    func fetchCitiesFromPersistentStore(callback: ([City]) -> ()) {
        let realm = try! Realm()

        let cityEntities = realm.objects(CityEntity)
        
        var cities: [City] = []
        for cityEntity in cityEntities {
            let city = City(title: cityEntity.title, ID: cityEntity.ID, placeID: cityEntity.placeID, temp: cityEntity.temp, lat: cityEntity.lat, lng: cityEntity.lng)
            cities.append(city)
        }
        callback(cities)
    }
    
    func removeCityFromPersistentStore(city: City) {
        let realm = try! Realm()

        realm.beginWrite()

        let predicate = NSPredicate(format: "ID = %@", argumentArray: [city.ID])
        let cityEntities = realm.objects(CityEntity).filter(predicate)
        
        realm.deleteWithNotification(cityEntities)

        try! realm.commitWrite()
    }
    
    func updateWeather() {
        let realm = try! Realm()
        
        let sortDescriptor = SortDescriptor(property: "title", ascending: true)
        let cityEntities = realm.objects(CityEntity).sorted([sortDescriptor])
        var cities: [City] = []
        for cityEntity in cityEntities {
            let city = City(title: cityEntity.title, ID: cityEntity.ID, placeID: cityEntity.placeID, temp: cityEntity.temp, lat: cityEntity.lat, lng: cityEntity.lng)
            cities.append(city)
        }

        for (index, city) in cities.enumerate() {
            let delay = (Double(index) * 0.5) * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                // Workaround error 429: Too many requests

                let method = Alamofire.Method.GET
                let url = "http://api.openweathermap.org/data/2.5/weather"
                let parameters: [String: AnyObject] = ["lat": city.lat, "lon": city.lng, "units": "metric", "cnt": 1, "APPID": openWeatherMapKey]
                
                Alamofire.Manager.sharedInstance.request(method, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
                    switch response.result {
                    case .Success(let JSON):
                        guard let weatherData = JSON as? [String: AnyObject] else {
                            return
                        }
                        let temp = weatherData["main"]!["temp"] as! Double
//                        let weather = Weather(dt: weatherData["dt"] as! Double, temp: weatherData["main"]!["temp"] as! Double, pressure: weatherData["main"]!["pressure"] as! Double, icon: weatherData["weather"]![0]["icon"] as! String)
                        let predicate = NSPredicate(format: "ID = %@", argumentArray: [city.ID])
                        let cityEntities = realm.objects(CityEntity).filter(predicate)
                        if cityEntities.count == 1 {
                            realm.beginWrite()

                            cityEntities[0].temp = temp
                            realm.addWithNotification(cityEntities[0], update: true)
                            try! realm.commitWrite()
                        }
                        
                    case .Failure(let error):
                        print(error)
                    }
                }
            }
        }
    }


}