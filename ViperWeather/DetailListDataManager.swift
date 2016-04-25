//
//  DetailListDataManager.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import Foundation
import RealmSwift
import Alamofire


protocol DetailListDataManagerInputProtocol: class {
    
    weak var interactor: DetailListDataManagerOutputProtocol! { get set }
    
    func getDetailCity(city: City, callback: (City) -> ())
    func getWeatherForCity(city: City, callback: ([Weather]) -> ())
    func updateCityInPersistentStore(city: City)
}

protocol DetailListDataManagerOutputProtocol: class {
    
    var dataManager: DetailListDataManagerInputProtocol! { get set }
}


class DetailListDataManager {
    
    weak var interactor: DetailListDataManagerOutputProtocol!
    
}

extension DetailListDataManager: DetailListDataManagerInputProtocol {
    
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
                let city = City(title: city.title, placeID: city.placeID, currentWeather: city.currentWeather, lat: lat, lng: lng)
                callback(city)
                
            case .Failure(let error):
                print(error)
                callback(city)
            }
        }
    }
    
    func getWeatherForCity(city: City, callback: ([Weather]) -> ()) {
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            // Workaround error 429: Too many requests

            let method = Alamofire.Method.GET
            let url = "http://api.openweathermap.org/data/2.5/forecast/daily"
            let parameters: [String: AnyObject] = ["lat": city.lat, "lon": city.lng, "units": "metric", "cnt": "10", "APPID": openWeatherMapKey]
            
            Alamofire.Manager.sharedInstance.request(method, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
                switch response.result {
                case .Success(let JSON):
                    print(JSON)
                    guard let list = JSON["list"] as? [[String: AnyObject]] else {
                        callback([])
                        return
                    }
                    var weatherList: [Weather] = []
                    for weatherData in list {
                        let weather = Weather(dt: weatherData["dt"] as! Double, temp: weatherData["temp"]!["eve"] as! Double, pressure: weatherData["pressure"] as! Double, icon: weatherData["weather"]![0]["icon"] as! String)
                        weatherList.append(weather)
                    }
                    callback(weatherList)
                    
                case .Failure(let error):
                    print(error)
                    callback([])
                }
            }
        }
    }
    
    func updateCityInPersistentStore(city: City) {
        let realm = try! Realm()
        
        realm.beginWrite()
        let predicate = NSPredicate(format: "placeID = %@", argumentArray: [city.placeID])
        let cityEntities = realm.objects(CityEntity).filter(predicate)
        
        for cityEntity in cityEntities {
            cityEntity.lat = city.lat
            cityEntity.lng = city.lng
        }
        
        realm.add(cityEntities, update: true)
        
        try! realm.commitWrite()
    }
}
