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
        return String(temp) + "℃"
    }
}