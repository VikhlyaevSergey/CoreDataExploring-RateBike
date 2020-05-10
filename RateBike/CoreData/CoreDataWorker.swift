//
//  GeneralWorker.swift
//  RateBike
//
//  Created by Сергей Вихляев on 04.05.2020.
//  Copyright (c) 2020 Сергей Вихляев. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import CoreData

// Maybe it will be nessessary later
class CoreDataError: Error {
    
    fileprivate let noObjectMessageCase = "Object for"
    
    enum CoreDataErrorCase {
        case noObject(String)
        case noEntity(String)
        case savingFalure
        case savingFalureWhileDeleting
        case dataBaseIsNotAvalible
    }
    
    let message: String
    let code: Int16
    
    init(errorCase: CoreDataErrorCase) {
        switch errorCase  {
        case .noObject(let objectKey):
            message = "Object with class: \(objectKey) can't be fetched from DataBase"
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
// -

protocol CoreDataWorkerProtocol {
    func checkPreLoadedData() -> Bool
    func saveData(dataAsArray: NSArray, completion: (Bool, [Bike]?, Error?)->())
}

// MARK:- CoreDataWorker
class CoreDataWorker {
    
    // MARK: Params
    static let shared: CoreDataWorkerProtocol = CoreDataWorker() // B-|
    
    fileprivate let bikeEntityName = "Bike"
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: Func-s
    private init() {}
    
}

// MARK:- CoreDataWorkerProtocol
extension CoreDataWorker: CoreDataWorkerProtocol {
    
    func checkPreLoadedData() -> Bool {
        let fetchRequest: NSFetchRequest<Bike> = Bike.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id != nil")
        
        var records = 0
        do {
            records = try context.count(for: fetchRequest)
            print("Is Data there already")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return records != 0
    }
    
    func saveData(dataAsArray: NSArray, completion: (Bool, [Bike]?, Error?) -> ()) {
        
        var bikes: [Bike] = []
        
        for dictionary in dataAsArray {
            
            // Creating object
            guard let entity = NSEntityDescription.entity(forEntityName: bikeEntityName, in: context) else {
                completion(false, nil, CoreDataError(errorCase: .noEntity(bikeEntityName)))
                break
            }
            
            var bike = NSManagedObject(entity: entity, insertInto: context) as! Bike
            
            DefaultDataPlistWorker.shared.getBikeFromDictionary(dictionary as! [String : Any], into: &bike)
            
            bikes.append(bike)
        }
        
        completion(true, bikes, nil)
    }
}
