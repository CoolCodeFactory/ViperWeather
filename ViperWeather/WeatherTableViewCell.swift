//
//  WeatherTableViewCell.swift
//  ViperWeather
//
//  Created by Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    var weather: Weather? {
        didSet {
            if let weather = weather {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEE, dd MMMM"
                dateLabel.text = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: weather.dt))
                
                weatherLabel.text = weather.tempString
                
                weatherIcon.image = weatherImageWithName(weather.icon)
            } else {
                dateLabel.text = nil
                weatherLabel.text = nil
                weatherIcon.image = nil
            }
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        
        weather = nil
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
