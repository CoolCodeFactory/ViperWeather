//
//  DetailListDetailInteractor.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import Foundation


protocol DetailListDetailInteractorInputProtocol: class {
    
    weak var presenter: DetailListDetailInteractorOutputProtocol! { get set }
}

protocol DetailListDetailInteractorOutputProtocol: class {
    
}

class DetailListDetailInteractor {
    
    weak var presenter: DetailListDetailInteractorOutputProtocol!
    
    var dataManager: DetailListDetailDataManagerInputProtocol!
}

extension DetailListDetailInteractor: DetailListDetailInteractorInputProtocol {

}

extension DetailListDetailInteractor: DetailListDetailDataManagerOutputProtocol {
    
}