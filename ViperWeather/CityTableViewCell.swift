//
//  CityTableViewCell.swift
//  ViperWeather
//
//  Created by Dima on 05/04/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    var city: City? {
        didSet {
            if let city = city {
                let components = city.title.componentsSeparatedByString(", ")
                if components.count > 1 {
                    titleLabel.text = components[0] + ", " + components[1]
                } else if components.count == 1 {
                    titleLabel.text = components[0]
                } else {
                    titleLabel.text = city.title
                }
            } else {
                titleLabel.text = " "
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
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
}
