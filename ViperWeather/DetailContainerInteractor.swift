//
//  DetailContainerInteractor.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import Foundation


protocol DetailContainerInteractorInputProtocol: class {
    
    weak var presenter: DetailContainerInteractorOutputProtocol! { get set }
}

protocol DetailContainerInteractorOutputProtocol: class {
    
}

class DetailContainerInteractor {
    
    weak var presenter: DetailContainerInteractorOutputProtocol!
    
    var dataManager: DetailContainerDataManagerInputProtocol!
    
}

extension DetailContainerInteractor: DetailContainerInteractorInputProtocol {

}

extension DetailContainerInteractor: DetailContainerDataManagerOutputProtocol {
    
}