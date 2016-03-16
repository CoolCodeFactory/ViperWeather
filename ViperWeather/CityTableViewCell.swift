//
//  AddTableViewCell.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 02/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    var city: City? {
        didSet {
            titleLabel.text = city?.title
            IDLabel.text = city?.ID
            placeIDLabel.text = city?.placeID
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var placeIDLabel: UILabel!
    
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
