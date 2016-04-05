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
            self.weatherContainerView.hidden = true
            self.activityIndicatorView.hidden = false
            self.presenter.getWeatherForCity(city)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func weatherImageWithName(name: String) -> UIImage? {
        switch name {
        case "01d", "01n": // clear sky
            return UIImage(named: "sunny-icon-bold")
        case "02d", "02n": // few clouds
            return UIImage(named: "mostly-sunny-icon-bold")
        case "03d", "03n": // scattered clouds
            return UIImage(named: "mostly-cloudy-icon-bold")
        case "04d", "04n": // broken clouds
            return UIImage(named: "cloudy-icon-bold")
        case "09d", "09n": // shower rain
            return UIImage(named: "raining-icon-bold")
        case "10d", "10n": // rain
            return UIImage(named: "shower-icon-bold-2")
        case "11d", "11n": // thunderstorm
            return UIImage(named: "thunder-storm-icon-bold")
        case "13d", "13n": // snow
            return UIImage(named: "snowing-icon-bold")
        case "50d", "50n": // mist
            return UIImage(named: "windy-icon-bold")
        default:
            return nil
        }
    }
}

extension DetailViewController: DetailInterfaceProtocol {
    
    func showEmpty() {
        self.city = nil
    }
    
    func showCity(city: City) {
        self.city = city
        
        self.weatherContainerView.hidden = false
        self.activityIndicatorView.hidden = true
        
        self.weatherLabel.text = city.tempString
        
        if let icon = city.currentWeather?.icon {
            self.weatherIconImageView.image = self.weatherImageWithName(icon)
        }
//        let request = NSURLRequest(URL: NSURL(string: "http://openweathermap.org/img/w/\(currentWeather.icon).png")!)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { [weak self] (response, data, error) -> Void in
//            if error == nil {
//                guard let data = data else { return }
//                let image = UIImage(data: data)
//                self?.weatherIconImageView.image = image
//            } else {
//                // Handle error
//            }
//        })
    }
}
