//
//  DetailListAssembler.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit
import Swinject


class DetailListAssembler: Assembler {

    required init(parentAssembler: Assembler) {
        try! super.init(assemblies: [DetailListContainer()], parentAssembler: parentAssembler)
    }
}

extension DetailListAssembler {
    
    func presentDetailListViewController(fromViewController fromViewController: UIViewController, city: City) {
        
        let viewController = self.viewController()
        viewController.city = city
        
        fromViewController.navigationController!.pushViewController(viewController, animated: true)
    }
    
    func presentDetailListViewController(fromViewController fromViewController: UIViewController, inView view: UIView, city: City) {
        let childViewController = self.viewController()
        childViewController.city = city
        
        fromViewController.addChildViewController(childViewController)
        childViewController.view.frame = view.frame
        view.addSubview(childViewController.view)
        
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let childView = childViewController.view
        let views: [String : AnyObject] = ["childView": childView]
        
        var childViewLayoutConstraint: [NSLayoutConstraint] = []
        childViewLayoutConstraint += NSLayoutConstraint.constraintsWithVisualFormat("|-(0)-[childView]-(0)-|", options: [], metrics: nil, views: views)
        childViewLayoutConstraint += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[childView]-(0)-|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(childViewLayoutConstraint)

        childViewController.didMoveToParentViewController(fromViewController)
    }
    
    func storyboard() -> SwinjectStoryboard {
        let storyboardName = "Detail"
        let bundle = NSBundle.mainBundle()
        return SwinjectStoryboard.create(name: storyboardName, bundle: bundle, container: resolver)
    }
    
    func viewController() -> DetailListViewController {
        return storyboard().instantiateViewControllerWithIdentifier("DetailListViewControllerID") as! DetailListViewController
    }
    
}