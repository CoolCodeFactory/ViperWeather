//
//  ChildDataManager.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import Foundation
import RealmSwift
import Alamofire


protocol ChildDataManagerInputProtocol: class {
    
    weak var interactor: ChildDataManagerOutputProtocol! { get set }
}

protocol ChildDataManagerOutputProtocol: class {
    
    var dataManager: ChildDataManagerInputProtocol! { get set }
}


class ChildDataManager {
    
    weak var interactor: ChildDataManagerOutputProtocol!
}

extension ChildDataManager: ChildDataManagerInputProtocol {
    
}
