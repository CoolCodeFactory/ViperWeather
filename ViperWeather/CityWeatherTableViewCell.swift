//
//  AddTableViewCell.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 02/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {

    var city: City? {
        didSet {
            if let city = city {
                let components = city.title.componentsSeparatedByString(", ")
                if components.count > 0 {
                    titleLabel.text = components[0]
                } else {
                    titleLabel.text = city.title
                }
                tempLabel.text = city.tempString
                
                if let icon = city.currentWeather?.icon {
                    self.weatherIconImageView.image = self.weatherImageWithName(icon)
                }
            } else {
                titleLabel.text = " "
                tempLabel.text = " "
                weatherIconImageView.image = nil
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let selectedBackgroundView = UIView(frame: CGRect.zero)
        selectedBackgroundView.backgroundColor = MaterialColor.lightBlueColor()
        self.selectedBackgroundView = selectedBackgroundView
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        city = nil
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
