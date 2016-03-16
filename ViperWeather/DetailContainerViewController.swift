//
//  DetailContainerViewController.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit

class DetailContainerViewController: UIViewController {

    // MARK: - VIPER Properties
    var presenter: DetailContainerPresenterProtocol!
    
    var city: City!
    
    @IBOutlet weak var detailContentView: UIView!
    @IBOutlet weak var detailListContentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = city.title
        
        self.presenter.presentDetailViewControllerInView(detailContentView, city: city)
        self.presenter.presentDetailListViewControllerInView(detailListContentView, city: city)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailContainerViewController: DetailContainerInterfaceProtocol {
    
}
