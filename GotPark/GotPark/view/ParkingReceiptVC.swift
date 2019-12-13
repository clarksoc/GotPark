//
//  ParkingReceiptVC.swift
//  GotPark
//
//  Created by Richard Perocho on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit

class ParkingReceiptVC: UIViewController {

    @IBOutlet weak var lblCarPlate: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblBuildingCode: UILabel!
    @IBOutlet weak var lblParkingCost: UILabel!
    @IBOutlet weak var lblSuite: UILabel!
    
    var parkPlate: String! = ""
    var date: Date! = Date()
    var duration: Int! = 0
    var buildingCode: Int! = 0
    var parkingCost: Int! = 0
    var suiteNum: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        lblCarPlate.text = self.parkPlate
        lblDate.text = formatter.string(from: self.date)
        if(self.duration == 1){
            lblDuration.text = String(self.duration) + " Hour"
        }
        else{
            lblDuration.text = String(self.duration) + " Hours"
        }
        lblBuildingCode.text = String(self.buildingCode)
        lblParkingCost.text = "$" + String(self.parkingCost)
        lblSuite.text = String(self.suiteNum)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
