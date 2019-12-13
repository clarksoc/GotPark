//
//  NewParkingVC.swift
//  GotPark
//
//  Created by Richard Perocho on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit

class NewParkingVC: UIViewController {

    @IBOutlet var txtBuildingCode: UITextField!
    @IBOutlet var pkNumHours: UIPickerView!
    @IBOutlet var txtPlateNum: UITextField!
    @IBOutlet var txtHostSuit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func requestParking(_ sender: Any) {
        
    }
    
    func populatePicker() {
        func populatePickers(){
            //initialize array data
            //coffeeData = ["Dark Roast", "Original Blend", "French Vannilla", "Latte"]
            //coffeeAmount = [1.20, 0.90, 1.25, 2.00]
            
            //connect data
            //self.coffeePicker.delegate = self
            //self.coffeePicker.dataSource = self
        }
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
