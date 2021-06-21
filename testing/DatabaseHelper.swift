//
//  DatabaseHelper.swift
//  testing
//
//  Created by manish on 09/06/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    static var sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    func saveData(object : [String: String]) {
        
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context!) as! Person
        person.name = object["name"]
        person.profession = object["profession"]
        do {
            try context?.save()
        } catch  {
            print("data not saved")
        }
    }
    
    func getData() -> [Person]{
        var personData = [Person]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            personData = try context?.fetch(fetchRequest) as! [Person]
        } catch  {
            print("no data")
        }
        return personData

    }
    
    func deletedata(index:Int) -> [Person] {
        var personData = getData()
        context?.delete(personData[index])
        personData.remove(at: index)
        do {
            try context?.save()
        } catch  {
            print("data not saved")
        }
        return personData
        
    }
}
