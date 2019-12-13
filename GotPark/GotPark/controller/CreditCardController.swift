//
//  CreditCardController.swift
//  GotPark
//
//  Created by Adrian Gonzalez Madruga on 2019-12-12.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit
import CoreData

public class CreditCardController{
    
    func insertCreditCard(newCreditCard: CreditCard){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let PaymentEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "PaymentEntity", in: managedContext)
        
        //if we have access to user table
        if (PaymentEntity != nil){
            let creditCard = NSManagedObject(entity: PaymentEntity!, insertInto: managedContext)
            
            creditCard.setValue(newCreditCard.email, forKey: "email")
            creditCard.setValue(newCreditCard.cardName, forKey: "creditName")
            creditCard.setValue(newCreditCard.creditCard, forKey: "creditNumber")
            creditCard.setValue(newCreditCard.cvv, forKey: "creditCVV")
            creditCard.setValue(newCreditCard.expiryDate, forKey: "creditExpiry")
            
            do{
                //to perform insert operation on database table
                try managedContext.save()
                
            }catch let error as NSError{
                print("Insert creditCard failed...\(error), \(error.userInfo)")
            }
        }
    }
    
    func updateCreditCard(creditCard : CreditCard, oldEmail : String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PaymentEntity")
        
        fetchRequest.predicate = NSPredicate(format: "email = %@", oldEmail)
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            
            let existingCreditCard = result[0] as! NSManagedObject
            
            existingCreditCard.setValue(creditCard.email, forKey: "email")
            existingCreditCard.setValue(creditCard.cardName, forKey: "creditName")
            existingCreditCard.setValue(creditCard.creditCard, forKey: "creditNumber")
            existingCreditCard.setValue(creditCard.cvv, forKey: "creditCVV")
            existingCreditCard.setValue(creditCard.expiryDate, forKey: "creditExpiry")
            
            do{
                try managedContext.save()
                print("CreditCard update Successful")
            }catch{
                print("CreditCard update unsuccessful")
            }
        }catch{
            print("CreditCard update unsuccessful")
        }
        
    }
    
    func deleteCreditCard(email: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PaymentEntity")
        
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            let existingUser = result[0] as! NSManagedObject
            
            managedContext.delete(existingUser)
            
            do{
                try managedContext.save()
                print("CreditCard delete Successful")
            }catch{
                print("CreditCard delete unsuccessful")
            }
            
        }catch{
            
        }
        
        
    }
    
    func getSelectedCreditCard(email: String) -> CreditCard?{
        let allCreditCards = (self.getAllCreditCards() ?? nil)!
        
        if (allCreditCards != nil){
            for creditCard in allCreditCards{
                let em = creditCard.value(forKey: "email") as! String
                if (em == email){
                    return CreditCard(email: em, creditCard: (creditCard.value(forKey: "creditNumber")as! String), expiryDate: (creditCard.value(forKey: "creditExpiry")as! String), cvv: (creditCard.value(forKey: "creditCVV")as! String), cardName: (creditCard.value(forKey: "creditName")as! String))
                }
            }
        }
        return nil
    }
    
    func getAllCreditCards() -> [NSManagedObject]?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PaymentEntity")
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        }catch{
            print("Data fetching Unsuccessful")
        }
        return nil
    }
}
