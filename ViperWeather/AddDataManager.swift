//
//  AddDataManager.swift
//  ViperWeather
//
//  Created by Dmitri Utmanov on 01/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire


protocol AddDataManagerInputProtocol: class {
    
    weak var interactor: AddDataManagerOutputProtocol! { get set }
    
    func fetchCitiesWithName(name: String, callback: ([City]) -> ())
    func saveCityToPersistentStore(city: City)
}

protocol AddDataManagerOutputProtocol: class {
    
    var dataManager: AddDataManagerInputProtocol! { get set }
}


class AddDataManager {
    
    weak var interactor: AddDataManagerOutputProtocol!
}

extension AddDataManager: AddDataManagerInputProtocol {

    func fetchCitiesWithName(name: String, callback: ([City]) -> ()) {
        let method = Alamofire.Method.GET
        let url = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
        let parameters = ["input": "\(name)", "types": "(cities)", "key": googleMapKey]
        
        Alamofire.Manager.sharedInstance.request(method, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            switch response.result {
            case .Success(let JSON):
                let predictions = JSON["predictions"] as! [[String: AnyObject]]
                var cities: [City] = []
                for prediction in predictions {
                    let city = City(title: prediction["description"] as! String, placeID: prediction["place_id"] as! String, currentWeather: nil, lat: 0.0, lng: 0.0)
                    cities.append(city)
                }
                callback(cities)
                
            case .Failure(let error):
                print(error)
                callback([])
            }
        }
    }
    
    func saveCityToPersistentStore(city: City) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "placeID == %@", argumentArray: [city.placeID])
        let cities = realm.objects(CityEntity).filter(predicate)
        if cities.count > 0 {
            return
        }
        
        realm.beginWrite()
        
        let cityEntity = CityEntity()
        cityEntity.title = city.title
        cityEntity.placeID = city.placeID
        
        realm.add(cityEntity, update: false)
        
        try! realm.commitWrite()
    }
}