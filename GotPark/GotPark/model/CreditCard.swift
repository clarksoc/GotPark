//
//  CreditCard.swift
//  GotPark
//
//  Created by Adrian Gonzalez Madruga on 2019-12-12.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import Foundation
class CreditCard {
    var email: String
    var creditCard: String
    var expiryDate: String
    var cvv: String
    var cardName: String
    
    init(email: String, creditCard: String, expiryDate: String, cvv: String, cardName: String) {
    self.email = email
    self.creditCard = creditCard
    self.expiryDate = expiryDate
    self.cvv = cvv
    self.cardName = cardName
    }
}
