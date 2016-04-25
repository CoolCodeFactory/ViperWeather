//
//  City.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 01/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import Foundation
import RealmSwift


struct City {
    let title: String
    let placeID: String
    let currentWeather: Weather?
    
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    var tempString: String {
        guard let currentWeather = self.currentWeather else {
            return "..." + "℃"
        }
        if currentWeather.temp == WeatherEntity.TempDefault {
            return "..." + "℃"
        } else {
            let temp = Double(round(10.0 * currentWeather.temp) / 10.0)
            return String(temp) + "℃"
        }
    }
    
    func isLocationEnable() -> Bool {
        if self.lat == 0.0 && self.lng == 0.0 {
            return false
        }
        return true
    }
}


class CityEntity: Object {
    dynamic var title: String = ""
    dynamic var placeID: String = ""
    dynamic var lat: Double = 0.0
    dynamic var lng: Double = 0.0
    
    dynamic var currentWeather: WeatherEntity?

    func delete(realm: Realm) {
        if let currentWeather = currentWeather {
            realm.delete(currentWeather)
        }
        realm.delete(self)
    }
    
    override static func primaryKey() -> String? {
        return "placeID"
    }
}
