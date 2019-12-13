//
//  Receipt.swift
//  GotPark
//
//  Created by Richard Perocho on 2019-12-13.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import Foundation
class Receipt {
    var buildingCode: Int
    var date: Date
    var duration: Int
    var parkingCost: Int
    var parkingPlate: String
    var suitNumber: Int
    
    init(buildingCode: Int, date: Date, duration: Int, parkingCost: Int, parkingPlate: String, suitNumber: Int) {
        self.buildingCode = buildingCode
        self.date = date
        self.duration = duration
        self.parkingCost = parkingCost
        self.parkingPlate = parkingPlate
        self.suitNumber = suitNumber
    }
}
