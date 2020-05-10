//
//  DefaultDataPlistWorker.swift
//  RateBike
//
//  Created by Сергей Вихляев on 06.05.2020.
//  Copyright © 2020 Сергей Вихляев. All rights reserved.
//

import Foundation
import UIKit

protocol DefaultDataPlistWorkerProtocol {
    func saveDataFromFileToCoreData(completion: (Bool, [Bike]?, Error?)->())
    func getBikeFromDictionary(_ dictionary: [String: Any], into bikeObject: inout Bike)
}

// MARK:- DefaultDataPlistWorker
class DefaultDataPlistWorker {
    
    // MARK: Params
    static let shared: DefaultDataPlistWorkerProtocol = DefaultDataPlistWorker()
    
    fileprivate let fileName = "data"
    fileprivate let fileType = "plist"
    
    private var dataFromFile: NSArray!
    
    // MARK: Func-s
    private init() {
        dataFromFile = getDataFromFile()
    }
    
    private func getDataFromFile() -> NSArray {
        guard let pathToFile = Bundle.main.path(forResource: fileName, ofType: fileType), let dataArray = NSArray(contentsOfFile: pathToFile) else { return [] }
        
        return dataArray
    }
}

// MARK:- DefaultDataPlistWorkerProtocol
extension DefaultDataPlistWorker: DefaultDataPlistWorkerProtocol {
    func saveDataFromFileToCoreData(completion: (Bool, [Bike]?, Error?)->()) {
        CoreDataWorker.shared.saveData(dataAsArray: self.dataFromFile, completion: completion)
    }
    
    func getBikeFromDictionary(_ bikeDictionary: [String: Any], into bikeObject: inout Bike) {
        
        // Parsing
        bikeObject.id = bikeDictionary["id"] as! Int16
        bikeObject.mark = bikeDictionary["mark"] as? String
        bikeObject.model = bikeDictionary["model"] as? String
        bikeObject.rating = bikeDictionary["rating"] as! Double
        bikeObject.lastStarted = bikeDictionary["lastStarted"] as? Date
        bikeObject.timesDriven = bikeDictionary["timesDriven"] as! Int16
        bikeObject.myCoice = bikeDictionary["myChoice"] as! Bool
        
        // Image
        bikeObject.imageSource = bikeDictionary["imageSource"] as? String
        
        if let colorDictionary = bikeDictionary["tintColor"] as? [String: Float] {
            do {
                bikeObject.tintColor = try UIColor.getColor(colorDictionary: colorDictionary)
            } catch {
                print("Error while parsing from data.plist")
            }
        }
    }
}
