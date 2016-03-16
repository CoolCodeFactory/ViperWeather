//
//  DetailContainerDataManager.swift
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


protocol DetailContainerDataManagerInputProtocol: class {
    
    weak var interactor: DetailContainerDataManagerOutputProtocol! { get set }
}

protocol DetailContainerDataManagerOutputProtocol: class {
    
    var dataManager: DetailContainerDataManagerInputProtocol! { get set }
}


class DetailContainerDataManager {
    
    weak var interactor: DetailContainerDataManagerOutputProtocol!
    
}

extension DetailContainerDataManager: DetailContainerDataManagerInputProtocol {
    
}
