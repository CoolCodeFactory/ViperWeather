//
//  ChildAssembler.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


class ChildAssembler: Assembler {

    required init(parentAssembler: Assembler) {
        try! super.init(assemblies: [ChildContainer()], parentAssembler: parentAssembler)
    }
}

extension ChildAssembler {
    
    func presentChildViewController(fromViewController fromViewController: UIViewController) {
        let viewController = self.viewController()
        // setup viewController
        
        fromViewController.navigationController!.pushViewController(viewController, animated: true)
    }
    
    func storyboard() -> UIStoryboard {
        let storyboardName = "Detail"
        let bundle = NSBundle.mainBundle()
        return SwinjectStoryboard.create(name: storyboardName, bundle: bundle, container: resolver)
    }
    
    func viewController() -> ChildViewController {
        return storyboard().instantiateViewControllerWithIdentifier("ChildViewControllerID") as! ChildViewController
    }
}