//
//  DetailListDetailViewController.swift
//  ViperWeather
//
//  Created Dima on 16/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit


class DetailListDetailViewController: UIViewController {

    // MARK: - VIPER Properties
    var presenter: DetailListDetailPresenterProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Update data.
    }

    
    // MARK: ChildViewController Presentation Action
    
    // Uncomment this snippet for present new ViewController after current ViewController called viewDidAppear func
    // or paste line to another func (e.g. tap on UIBitton -> IBAction)
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presenter.presentChildViewController()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DetailListDetailViewController: DetailListDetailInterfaceProtocol {
    
}
