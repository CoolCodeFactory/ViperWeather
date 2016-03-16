//
//  DetailViewController.swift
//  ViperWeather
//
//  Created by Dmitri Utmanov on 02/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - VIPER Properties
    var presenter: DetailPresenterProtocol!
    
    var city: City?
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var weatherContainerView: UIView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
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

        // Do any additional setup after loading the view.
        activityIndicatorView.color = MaterialColor.cyanColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let city = city {
            if city.isLocationEnable() == false {
                self.weatherContainerView.hidden = true
                self.activityIndicatorView.hidden = false
                self.presenter.getDetailCity(city)
            } else {
                self.weatherContainerView.hidden = true
                self.activityIndicatorView.hidden = false
                self.presenter.getWeatherForCity(city)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailViewController: DetailInterfaceProtocol {
    
    func showEmpty() {
        self.city = nil
    }
    
    func showCity(city: City) {
        self.city = city
        
        self.weatherContainerView.hidden = true
        self.activityIndicatorView.hidden = false
        
        self.presenter.getWeatherForCity(city)
    }
    
    func showWeatherForCity(weather: [Weather], city: City) {
        self.weatherContainerView.hidden = false
        self.activityIndicatorView.hidden = true
        
        if weather.count > 0 {
            let currentWeather = weather[0]
            self.weatherLabel.text = currentWeather.tempString

            let request = NSURLRequest(URL: NSURL(string: "http://openweathermap.org/img/w/\(currentWeather.icon).png")!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { [weak self] (response, data, error) -> Void in
                if error == nil {
                    guard let data = data else { return }
                    let image = UIImage(data: data)
                    self?.weatherIconImageView.image = image
                } else {
                    // Handle error
                }
            })
        }
        self.city = city
    }
}
