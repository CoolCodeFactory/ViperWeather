//
//  RootAssembly.swift
//  Architecture
//
//  Created by Dmitri Utmanov on 20/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import Swinject


class RootAssembler: Assembler {
    
    init(parentAssembler: Assembler) {
        try! super.init(assemblies: [RootContainer()], parentAssembler: parentAssembler)
    }
    
}

extension RootAssembler {
    
    func presentRootViewController(fromViewController fromViewController: UIViewController) {
        guard let navigationController = fromViewController as? UINavigationController else  {
            return
        }
        let viewController = storyboard().instantiateInitialViewController()! as! RootViewController
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func storyboard() -> SwinjectStoryboard {
        return SwinjectStoryboard.create(name: "Root", bundle: NSBundle.mainBundle(), container: resolver)
    }
    
}