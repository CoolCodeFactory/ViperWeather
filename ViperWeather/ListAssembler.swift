//
//  ListAssembler.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import Swinject


class ListAssembler: Assembler {

    required init(parentAssembler: Assembler) {
        try! super.init(assemblies: [ListContainer()], parentAssembler: parentAssembler)
    }
}

extension ListAssembler {
    
    func presentListViewController(fromViewController fromViewController: UIViewController) {
        let viewController = storyboard().instantiateViewControllerWithIdentifier("ListTableViewControllerID") as! ListTableViewController
        
        let navigationController = UINavigationController(rootViewController: viewController)

        let idiom = UIDevice.currentDevice().userInterfaceIdiom
        switch idiom {
        case .Phone:
            fromViewController.presentViewController(navigationController, animated: true, completion: nil)
            
        case .Pad:
            let splitViewController = UISplitViewController()
            let detailNavigationController = UINavigationController()
            splitViewController.viewControllers = [navigationController, detailNavigationController]
            
            splitViewController.presentsWithGesture = false
            splitViewController.preferredDisplayMode = .AllVisible

            fromViewController.presentViewController(splitViewController, animated: true, completion: nil)
            
        default:
            fatalError("Device is not supported yet")
        }
    }
    
    func storyboard() -> UIStoryboard {
        return SwinjectStoryboard.create(name: "List", bundle: NSBundle.mainBundle(), container: resolver)
    }
    
}