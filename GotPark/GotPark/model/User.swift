//
//  User.swift
//  GotPark
//
//  Created by Adrian Gonzalez Madruga on 2019-12-12.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import Foundation
class User {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var phoneNumber: String
    var carPlate: String
    
    init(firstName: String, lastName: String, email: String, password: String, phoneNumber: String, carPlate: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.carPlate = carPlate
    }
}
