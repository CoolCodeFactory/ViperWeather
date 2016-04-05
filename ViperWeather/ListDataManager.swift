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

    func getDetailCity(city: City, callback: (lat: Double, lng: Double) -> ())
    func getWeatherForCity(city: City, callback: (Weather?) -> ())

    func updateCityInPersistentStore(city: City, weather: Weather) -> City
    func updateCityInPersistentStore(city: City, lat: Double, lng: Double) -> City
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

        let sortDescriptor = SortDescriptor(property: "title", ascending: true)
        let cityEntities = realm.objects(CityEntity).sorted([sortDescriptor])
        
        var cities: [City] = []
        for cityEntity in cityEntities {
            
            let currentWeather: Weather?
            if let weather = cityEntity.currentWeather {
                currentWeather = Weather(dt: weather.dt, temp: weather.temp, pressure: weather.pressure, icon: weather.icon)
            } else {
                currentWeather = nil
            }
            let city = City(title: cityEntity.title, placeID: cityEntity.placeID, currentWeather: currentWeather, lat: cityEntity.lat, lng: cityEntity.lng)
            cities.append(city)
        }
        callback(cities)
    }
    
    func removeCityFromPersistentStore(city: City) {
        let realm = try! Realm()

        realm.beginWrite()

        let predicate = NSPredicate(format: "placeID = %@", argumentArray: [city.placeID])
        let cityEntities = realm.objects(CityEntity).filter(predicate)
        
        for cityEntity in cityEntities {
            cityEntity.delete(realm)
        }
//        realm.deleteWithNotification(cityEntities)
        
        try! realm.commitWrite()
    }
    
    func getDetailCity(city: City, callback: (lat: Double, lng: Double) -> ()) {
        let method = Alamofire.Method.GET
        let url = "https://maps.googleapis.com/maps/api/place/details/json"
        let parameters = ["placeid": "\(city.placeID)", "key": googleMapKey]
        
        Alamofire.Manager.sharedInstance.request(method, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            switch response.result {
            case .Success(let JSON):
                let result = JSON["result"] as! [String: AnyObject]
                let geometry = result["geometry"] as! [String: AnyObject]
                let location = geometry["location"] as! [String: AnyObject]
                let lat = location["lat"] as! Double
                let lng = location["lng"] as! Double
                callback(lat: lat, lng: lng)

            case .Failure(let error):
                print(error)
                callback(lat: 0.0, lng: 0.0)
            }
        }
    }
    
    func getWeatherForCity(city: City, callback: (Weather?) -> ()) {
        let method = Alamofire.Method.GET
        let url = "http://api.openweathermap.org/data/2.5/weather"
        let parameters: [String: AnyObject] = ["lat": city.lat, "lon": city.lng, "units": "metric", "cnt": 1, "APPID": openWeatherMapKey]
        
        Alamofire.Manager.sharedInstance.request(method, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            switch response.result {
            case .Success(let JSON):
                guard let weatherData = JSON as? [String: AnyObject] else {
                    callback(nil)
                    return
                }
                let weather = Weather(dt: weatherData["dt"] as! Double, temp: weatherData["main"]!["temp"] as! Double, pressure: weatherData["main"]!["pressure"] as! Double, icon: weatherData["weather"]![0]["icon"] as! String)
                callback(weather)
                
            case .Failure(let error):
                print(error)
                callback(nil)
            }
        }
    }

    func updateCityInPersistentStore(city: City, weather: Weather) -> City {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "placeID = %@", argumentArray: [city.placeID])
        let cityEntities = realm.objects(CityEntity).filter(predicate)
        
        realm.beginWrite()
        
        for cityEntity in cityEntities {
            let currentWeather: WeatherEntity
            if cityEntity.currentWeather != nil {
                currentWeather = cityEntity.currentWeather!
            } else {
                currentWeather = WeatherEntity()
            }
            currentWeather.dt = weather.dt
            currentWeather.icon = weather.icon
            currentWeather.pressure = weather.pressure
            currentWeather.temp = weather.temp
            
            cityEntity.currentWeather = currentWeather
        }
        
        realm.addWithNotification(cityEntities, update: true)
        
        try! realm.commitWrite()
        
        let city = City(title: city.title, placeID: city.placeID, currentWeather: weather, lat: city.lat, lng: city.lng)
        return city
    }
    
    func updateCityInPersistentStore(city: City, lat: Double, lng: Double) -> City {
        let realm = try! Realm()
        
        realm.beginWrite()
        let predicate = NSPredicate(format: "placeID = %@", argumentArray: [city.placeID])
        let cityEntities = realm.objects(CityEntity).filter(predicate)
        
        for cityEntity in cityEntities {
            cityEntity.lat = lat
            cityEntity.lng = lng
        }
        
        realm.addWithNotification(cityEntities, update: true)
        
        try! realm.commitWrite()
        
        let city = City(title: city.title, placeID: city.placeID, currentWeather: city.currentWeather, lat: lat, lng: lng)
        return city
    }
}
