//
//  DetailListDetailDataManager.swift
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


protocol DetailListDetailDataManagerInputProtocol: class {
    
    weak var interactor: DetailListDetailDataManagerOutputProtocol! { get set }
}

protocol DetailListDetailDataManagerOutputProtocol: class {
    
    var dataManager: DetailListDetailDataManagerInputProtocol! { get set }
}


class DetailListDetailDataManager {
    
    weak var interactor: DetailListDetailDataManagerOutputProtocol!
}

extension DetailListDetailDataManager: DetailListDetailDataManagerInputProtocol {
    
}
