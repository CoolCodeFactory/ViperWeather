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
                dateFormatter.dateStyle = .MediumStyle
                dateFormatter.timeStyle = .ShortStyle
                dateLabel.text = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: weather.dt))
                
                weatherLabel.text = weather.tempString
            } else {
                dateLabel.text = nil
                weatherLabel.text = nil
            }
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
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
}
