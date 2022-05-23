//
//  Colors.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

class Colors: NSObject {
    
    //MARK: COLORS HEX
    static let redMarvelColor = HEX(rgbValue: 0xED1D24)
    static let darkBackgroundColor = HEX(rgbValue: 0x202020)
    static let grayLineColor = HEX(rgbValue: 0x5B5B5B)

    //MARK: COLOR FUNCTIONS
    static func HEX(rgbValue:Int) -> UIColor {
        let red = CGFloat((rgbValue >> 16) & 0xFF)/255;
        let green = CGFloat((rgbValue >> 8) & 0xFF)/255;
        let blue = CGFloat(rgbValue & 0xFF)/255;
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1);
    }
}
