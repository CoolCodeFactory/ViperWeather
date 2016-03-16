//
//  MaterialColor.swift
//  ViperWeather
//
//  Created by Dmitri Utmanov on 02/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit

class MaterialColor: UIColor {
    
    
    private class func colorWithHex(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        return UIColor(red:red, green:green, blue:blue, alpha:alpha)
    }

    
    
    // Some convenience methods to create colors.  These colors will be as calibrated as possible.
    // These colors are cached.
    override class func darkGrayColor() -> UIColor {
        return MaterialColor.colorWithHex(0x424242)
    }
    override class func lightGrayColor() -> UIColor {
        return MaterialColor.colorWithHex(0xBDBDBD)
    }
    override class func blackColor() -> UIColor {
        return MaterialColor.colorWithHex(0x212121)
    }
    override class func grayColor() -> UIColor {
        return MaterialColor.colorWithHex(0x9E9E9E)
    }
    override class func redColor() -> UIColor {
        return MaterialColor.colorWithHex(0xF44336)
    }
    override class func greenColor() -> UIColor {
        return MaterialColor.colorWithHex(0x4CAF50)
    }
    override class func blueColor() -> UIColor {
        return MaterialColor.colorWithHex(0x2196F3)
    }
    override class func cyanColor() -> UIColor {
        return MaterialColor.colorWithHex(0x00BCD4)
    }
    override class func yellowColor() -> UIColor {
        return MaterialColor.colorWithHex(0xFFEB3B)
    }
    override class func magentaColor() -> UIColor {
        return MaterialColor.colorWithHex(0xF06292)
    }
    override class func orangeColor() -> UIColor {
        return MaterialColor.colorWithHex(0xFF9800)
    }
    override class func purpleColor() -> UIColor {
        return MaterialColor.colorWithHex(0x9C27B0)
    }
    override class func brownColor() -> UIColor {
        return MaterialColor.colorWithHex(0x795548)
    }
    
    class func deepPurpleColor() -> UIColor {
        return MaterialColor.colorWithHex(0x673AB7)
    }
    class func pinkColor() -> UIColor {
        return MaterialColor.colorWithHex(0xE91E63)
    }
    class func indigoColor() -> UIColor {
        return MaterialColor.colorWithHex(0x3F51B5)
    }
    class func lightBlueColor() -> UIColor {
        return MaterialColor.colorWithHex(0x03A9F4)
    }
    class func tealColor() -> UIColor {
        return MaterialColor.colorWithHex(0x009688)
    }
    class func lightGreenColor() -> UIColor {
        return MaterialColor.colorWithHex(0x8BC34A)
    }
    class func limeColor() -> UIColor {
        return MaterialColor.colorWithHex(0xCDDC39)
    }
    class func amberColor() -> UIColor {
        return MaterialColor.colorWithHex(0xFFC107)
    }
    class func deepOrangeColor() -> UIColor {
        return MaterialColor.colorWithHex(0xFF5722)
    }
    class func blueGrayColor() -> UIColor {
        return MaterialColor.colorWithHex(0x607D8B)
    }
}
