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
            let city = City(title: cityEntity.title, ID: cityEntity.ID, placeID: cityEntity.placeID, lat: cityEntity.lat, lng: cityEntity.lng)
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
    
}