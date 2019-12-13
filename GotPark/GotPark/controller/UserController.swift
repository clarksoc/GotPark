//
//  UserController.swift
//  GotPark
//
//  Created by Adrian Gonzalez Madruga on 2019-12-12.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit
import CoreData

public class UserController{
    
    func insertUser(newUser: User){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "UserEntity", in: managedContext)
        
        //if we have access to user table
        if (userEntity != nil){
            let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
            
            user.setValue(newUser.firstName, forKey: "firstName")
            user.setValue(newUser.lastName, forKey: "lastName")
            user.setValue(newUser.email, forKey: "email")
            user.setValue(newUser.password, forKey: "password")
            user.setValue(newUser.phoneNumber, forKey: "phoneNumber")
            user.setValue(newUser.carPlate, forKey: "carPlate")
            
            do{
                //to perform insert operation on database table
                try managedContext.save()
                
            }catch let error as NSError{
                print("Insert user failed...\(error), \(error.userInfo)")
            }
        }
    }
    
    func updateUser(user : User, oldEmail : String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        
        fetchRequest.predicate = NSPredicate(format: "email = %@", oldEmail)
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            
            let existingUser = result[0] as! NSManagedObject
            
            existingUser.setValue(user.firstName, forKey: "firstName")
            existingUser.setValue(user.lastName, forKey: "lastName")
            existingUser.setValue(user.email, forKey: "email")
            existingUser.setValue(user.password, forKey: "password")
            existingUser.setValue(user.phoneNumber, forKey: "phoneNumber")
            existingUser.setValue(user.carPlate, forKey: "carPlate")
            
            do{
                try managedContext.save()
                print("User update Successful")
            }catch{
                print("User update unsuccessful")
            }
        }catch{
            print("User update unsuccessful")
        }
        
    }
    
    func deleteUser(email: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            let existingUser = result[0] as! NSManagedObject
            
            managedContext.delete(existingUser)
            
            do{
                try managedContext.save()
                print("User delete Successful")
            }catch{
                print("User delete unsuccessful")
            }
            
        }catch{
            
        }
        
        
    }
    
    func getSelectedUser(email: String) -> User?{
        let allUsers = (self.getAllUsers() ?? nil)!
        
        if (allUsers != nil){
            for user in allUsers{
                let em = user.value(forKey: "email") as! String
                if (em == email){
                    return User(firstName: user.value(forKey: "firstName") as! String, lastName: user.value(forKey: "lastName") as! String, email: em, password: user.value(forKey: "password") as! String, phoneNumber: user.value(forKey: "phoneNumber") as! String, carPlate: user.value(forKey: "carPlate") as! String)
                }
            }
        }
        return nil
    }
    
    func validateUser(email: String, password: String) -> Bool{
        let allUsers = (self.getAllUsers() ?? nil)!
        
        if (allUsers != nil){
            for user in allUsers{
                let em = user.value(forKey: "email") as! String
                let pw = user.value(forKey: "password") as! String
                if (em == email && pw == password){
                    return true
                }
            }
        }
        return false
    }
    
    func getAllUsers() -> [NSManagedObject]?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        }catch{
            print("Data fetching Unsuccessful")
        }
        return nil
    }
}
