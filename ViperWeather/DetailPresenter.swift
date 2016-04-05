//
//  DetailPresenter.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import Swinject


protocol DetailPresenterProtocol: class {
    
    func getWeatherForCity(city: City)
}

protocol DetailInterfaceProtocol: class {
    
    var presenter: DetailPresenterProtocol!  { get set }
    
    func showEmpty()
    func showCity(city: City)
}

class DetailPresenter {
    
    weak private var interface: DetailInterfaceProtocol!
    private let interactor: DetailInteractorInputProtocol
    private let router: DetailRouterInputProtocol
    
    
    init(interface: DetailInterfaceProtocol, interactor: DetailInteractorInputProtocol, router: DetailRouterInputProtocol) {
        self.interface = interface
        self.interactor = interactor
        self.router = router
    }
}


extension DetailPresenter: DetailPresenterProtocol {
    
    func getWeatherForCity(city: City) {
        self.interactor.getWeatherForCity(city)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    
    func updateCity(city: City?) {
        guard let city = city else {
            self.interface.showEmpty()
            return
        }
        guard city.isLocationEnable() == true else {
            self.interface.showEmpty()
            return
        }
        self.interface.showCity(city)
    }
}

