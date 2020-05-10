//
//  Errors.swift
//  RateBike
//
//  Created by Сергей Вихляев on 06.05.2020.
//  Copyright © 2020 Сергей Вихляев. All rights reserved.
//

import Foundation
import UIKit

class BusinessLogicError: Error {
        
    enum CoreDataErrorCase {
        // UIColor exeption
        case canNotParseColor(Float, Float, Float)
        case noEntity(String)
        case savingFalure
        case savingFalureWhileDeleting
        case dataBaseIsNotAvalible
    }
    
    let message: String
    let code: Int16
    
    init(errorCase: CoreDataErrorCase) {
        switch errorCase  {
        case .canNotParseColor(let red, let green, let blue):
            message = "Can't parse color from red: \(red), green: \(green), blue: \(blue)"
            code = 1
        case .noEntity(let entityName):
            message = "Entity for key: \(entityName) did't found"
            code = 2
        case .savingFalure:
            message = "Entity can't be saved"
            code = 3
        case .savingFalureWhileDeleting:
            message = "Deleting was break in process. Reload or reinstall app"
            code = 4
        case .dataBaseIsNotAvalible:
            message = "Data Base can't be downloaded. DB will be clean..."
            code = 5
        
        }
    }
}
