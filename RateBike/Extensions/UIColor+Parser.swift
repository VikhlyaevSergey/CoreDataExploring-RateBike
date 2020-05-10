//
//  UIColor+Parser.swift
//  RateBike
//
//  Created by Сергей Вихляев on 06.05.2020.
//  Copyright © 2020 Сергей Вихляев. All rights reserved.
//

import Foundation
import UIKit



extension UIColor {
    class func getColor(colorDictionary: [String: Float]) throws -> UIColor {
        
        guard let red = colorDictionary["red"],
            let green = colorDictionary["green"],
            let blue = colorDictionary["blue"] else {
                throw BusinessLogicError(errorCase: .canNotParseColor(colorDictionary["red"] ?? 0,
                                                                      colorDictionary["green"] ?? 0,
                                                                      colorDictionary["blue"] ?? 0))
        }
        
        return UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
    }
}
