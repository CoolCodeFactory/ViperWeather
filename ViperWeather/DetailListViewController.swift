//
//  DetailListViewController.swift
//  ViperWeather
//
//  Created Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//
//  Generated via Swift-Viper templates by https://github.com/cooler333
//

import UIKit


class DetailListViewController: UITableViewController {

    let kWeatherTableViewCellReuseIdentifier = "WeatherTableViewCellReuseIdentifier"

    
    // MARK: - VIPER Properties
    var presenter: DetailListPresenterProtocol!

    var city: City!
    var weatherList: [Weather] = []
    
    
    override var nibName: String? {
        get {
            let classString = String(self.dynamicType)
            return classString
        }
    }
    override var nibBundle: NSBundle? {
        get {
            return NSBundle.mainBundle()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "WeatherTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: kWeatherTableViewCellReuseIdentifier)
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let city = city {
            if city.isLocationEnable() == false {
                self.presenter.getDetailCity(city)
            } else {
                self.presenter.getWeatherForCity(city)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailListViewController {
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kWeatherTableViewCellReuseIdentifier, forIndexPath: indexPath) as! WeatherTableViewCell
        cell.weather = weatherList[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
        
        // Uncomment this line to find out how Template does work
        let weather = weatherList[indexPath.row]
        self.presenter.presentDetailListDetailViewController(weather.tempString)
        
        */
    }
}

extension DetailListViewController: DetailListInterfaceProtocol {
    
    func showEmpty() {
        self.city = nil
        self.weatherList.removeAll()
    }
    
    func showCity(city: City) {
        self.city = city
        
        self.presenter.getWeatherForCity(city)
    }
    
    func showWeatherForCity(weather: [Weather], city: City) {
        self.city = city
        self.weatherList = weather
        
        self.tableView.reloadData()
    }

}
