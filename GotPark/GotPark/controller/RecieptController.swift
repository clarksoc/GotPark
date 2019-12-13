//
//  RecieptController.swift
//  GotPark
//
//  Created by Adrian Gonzalez Madruga on 2019-12-12.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit
import CoreData

public class ReceiptController {
    
    func insertReceipt(newReceipt: Receipt){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let parkingEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ParkingEntity", in: managedContext)
        
        if (parkingEntity != nil){
            let receipt = NSManagedObject(entity: parkingEntity!, insertInto: managedContext)
            
            receipt.setValue(newReceipt.buildingCode, forKey: "buildingCode")
            receipt.setValue(newReceipt.date, forKey: "date")
            receipt.setValue(newReceipt.duration, forKey: "duration")
            receipt.setValue(newReceipt.parkingCost, forKey: "parkCost")
            receipt.setValue(newReceipt.parkingPlate, forKey: "parkPlate")
            receipt.setValue(newReceipt.suiteNumber, forKey: "suiteNumber")
            
            do{
                //to perform insert operation on database table
                try managedContext.save()
                
            }catch let error as NSError{
                print("Insert receipt failed...\(error), \(error.userInfo)")
            }
        }
    }
}
