//
//  Weather.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import Foundation
import RealmSwift

struct Weather {
    let dt: Double
    let temp: Double
    let pressure: Double
    let icon: String
    
    var tempString: String {
        let temp = Double(round(10.0 * self.temp) / 10.0)
        return String(temp) + "℃"
    }
}

class WeatherEntity: Object {
    static let TempDefault = 999.999

    dynamic var dt: Double = 0.0
    dynamic var temp: Double = WeatherEntity.TempDefault
    dynamic var pressure: Double = 0.0
    dynamic var icon: String = ""
}
