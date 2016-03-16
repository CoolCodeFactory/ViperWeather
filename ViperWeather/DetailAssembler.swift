//
//  DetailAssembler.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import Swinject


class DetailAssembler: Assembler {

    required init(parentAssembler: Assembler) {
        try! super.init(assemblies: [DetailContainer()], parentAssembler: parentAssembler)
    }
}

extension DetailAssembler {
    
    func presentDetailViewController(fromViewController fromViewController: UIViewController, city: City) {
        let viewController = self.viewController()
        viewController.city = city
        
        fromViewController.navigationController!.pushViewController(viewController, animated: true)
    }
    
    func presentDetailViewController(fromViewController fromViewController: UIViewController, inView view: UIView, city: City) {
        let childViewController = self.viewController()
        childViewController.city = city

        fromViewController.addChildViewController(childViewController)
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
        return SwinjectStoryboard.create(name: "Detail", bundle: NSBundle.mainBundle(), container: resolver)
    }
    
    func viewController() -> DetailViewController {
        return storyboard().instantiateViewControllerWithIdentifier("DetailViewControllerID") as! DetailViewController
    }
    
}