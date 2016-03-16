//
//  DetailContainerAssembler.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


class DetailContainerAssembler: Assembler {
    
    required init(parentAssembler: Assembler) {
        try! super.init(assemblies: [DetailContainerContainer()], parentAssembler: parentAssembler)
    }
}

extension DetailContainerAssembler {
    
    func presentDetailContainerViewController(fromViewController fromViewController: UIViewController, city: City) {
        let viewController = self.viewController()
        viewController.city = city
        
        let idiom = UIDevice.currentDevice().userInterfaceIdiom
        switch idiom {
        case .Phone:
            fromViewController.navigationController!.pushViewController(viewController, animated: true)
            
        case .Pad:
            let navigationController = fromViewController.splitViewController?.viewControllers[1] as! UINavigationController
            navigationController.setViewControllers([viewController], animated: false)
            
        default:
            fatalError("Device is not supported yet")
        }

    }
    
    func storyboard() -> UIStoryboard {
        let storyboardName = "Detail"
        let bundle = NSBundle.mainBundle()
        return SwinjectStoryboard.create(name: storyboardName, bundle: bundle, container: resolver)
    }
    
    func viewController() -> DetailContainerViewController {
        return storyboard().instantiateInitialViewController() as! DetailContainerViewController
    }
}