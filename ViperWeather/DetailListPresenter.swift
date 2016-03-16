//
//  DetailListPresenter.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


protocol DetailListPresenterProtocol: class {
    
    func getDetailCity(city: City)
    func getWeatherForCity(city: City)
    
    func presentDetailListDetailViewController(testString: String)
}

protocol DetailListInterfaceProtocol: class {
    
    var presenter: DetailListPresenterProtocol!  { get set }
    
    func showEmpty()
    func showCity(city: City)
    func showWeatherForCity(weather: [Weather], city: City)
}

class DetailListPresenter {
    
    weak private var interface: DetailListInterfaceProtocol!
    private let interactor: DetailListInteractorInputProtocol
    private let router: DetailListRouterInputProtocol
    
    
    init(interface: DetailListInterfaceProtocol, interactor: DetailListInteractorInputProtocol, router: DetailListRouterInputProtocol) {
        self.interface = interface
        self.interactor = interactor
        self.router = router
    }
}


extension DetailListPresenter: DetailListPresenterProtocol {
    
    func getDetailCity(city: City) {
        self.interactor.getDetailCity(city)
    }
    
    func getWeatherForCity(city: City) {
        self.interactor.getWeatherForCity(city)
    }
    
    func presentDetailListDetailViewController(testString: String) {
        self.router.presentDetailListDetailViewController(fromViewController: self.interface as! UIViewController)
    }
}

extension DetailListPresenter: DetailListInteractorOutputProtocol {
    
    func foundDetailCity(city: City) {
        guard city.isLocationEnable() == true else {
            self.interface.showEmpty()
            return
        }
        self.interface.showCity(city)
    }
    
    func foundWeatherForCity(weather: [Weather], city: City) {
        self.interface.showWeatherForCity(weather, city: city)
    }
}

