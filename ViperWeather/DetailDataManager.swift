//
//  DetailDataManager.swift
//  ViperWeather
//
//  Created by Dmitri Utmanov on 02/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire


protocol DetailDataManagerInputProtocol: class {
    
    weak var interactor: DetailDataManagerOutputProtocol! { get set }
    
    func getDetailCity(city: City, callback: (City) -> ())
    func getWeatherForCity(city: City, callback: ([Weather]) -> ())
    func updateCityInPersistentStore(city: City)
}

protocol DetailDataManagerOutputProtocol: class {
    
    var dataManager: DetailDataManagerInputProtocol! { get set }
}


class DetailDataManager {
    
    weak var interactor: DetailDataManagerOutputProtocol!
}

extension DetailDataManager: DetailDataManagerInputProtocol {
    
    func getDetailCity(city: City, callback: (City) -> ()) {
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
                let city = City(title: city.title, ID: city.ID, placeID: city.placeID, lat: lat, lng: lng)
                callback(city)

            case .Failure(let error):
                print(error)
                callback(city)
            }
        }
    }
    
    func getWeatherForCity(city: City, callback: ([Weather]) -> ()) {
        let method = Alamofire.Method.GET
        let url = "http://api.openweathermap.org/data/2.5/forecast"
        let parameters: [String: AnyObject] = ["lat": city.lat, "lon": city.lng, "units": "metric", "cnt": 1, "APPID": openWeatherMapKey]
        
        Alamofire.Manager.sharedInstance.request(method, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            switch response.result {
            case .Success(let JSON):
                let list = JSON["list"] as! [[String: AnyObject]]
                var weatherList: [Weather] = []
                for weatherData in list {
                    let weather = Weather(dt: weatherData["dt"] as! Double, temp: weatherData["main"]!["temp"] as! Double, pressure: weatherData["main"]!["pressure"] as! Double, icon: weatherData["weather"]![0]["icon"] as! String)
                    weatherList.append(weather)
                }
                callback(weatherList)
                
            case .Failure(let error):
                print(error)
                callback([])
            }
        }
    }
    
    func updateCityInPersistentStore(city: City) {
        let realm = try! Realm()
        
        realm.beginWrite()
        let predicate = NSPredicate(format: "ID = %@", argumentArray: [city.ID])
        let cityEntities = realm.objects(CityEntity).filter(predicate)
        
        for cityEntity in cityEntities {
            cityEntity.lat = city.lat
            cityEntity.lng = city.lng
        }
        
        realm.add(cityEntities, update: true)
        
        try! realm.commitWrite()
    }
}
