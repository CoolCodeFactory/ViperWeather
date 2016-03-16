//
//  ChildInteractor.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import Foundation


protocol ChildInteractorInputProtocol: class {
    
    weak var presenter: ChildInteractorOutputProtocol! { get set }
}

protocol ChildInteractorOutputProtocol: class {
    
}

class ChildInteractor {
    
    weak var presenter: ChildInteractorOutputProtocol!
    
    var dataManager: ChildDataManagerInputProtocol!
}

extension ChildInteractor: ChildInteractorInputProtocol {

}

extension ChildInteractor: ChildDataManagerOutputProtocol {
    
}