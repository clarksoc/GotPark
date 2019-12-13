//
//  NewParkingVC.swift
//  GotPark
//
//  Created by Richard Perocho on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit

class NewParkingVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var txtBuildingCode: UITextField!
    @IBOutlet var pkNumHours: UIPickerView!
    @IBOutlet var txtPlateNum: UITextField!
    @IBOutlet var txtHostSuite: UITextField!
    
    var hours: [Int] = [Int]()
    var selectedHours: Int! = 0
    var parkingCost: [Int] = [Int]()
    var parkingAmount: Int! = 0
    
    let userController = UserController()
    let receiptController = ReceiptController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populatePicker()
        // Do any additional setup after loading the view.
    }

    @IBAction func requestParking(_ sender: Any) {
        let buildingCode = Int(txtBuildingCode.text!) ?? 0
        let plateNumber = txtPlateNum.text ?? ""
        let hostSuite = Int(txtHostSuite.text!) ?? 0
        
        if(selectedHours == 0){
            self.selectedHours = 1
            self.parkingAmount = 4
        }
        if (plateNumber == userController.getSelectedUser(email: HomeVC.email)!.carPlate && buildingCode > 0 && hostSuite > 0) {
            let receipt = Receipt(buildingCode: buildingCode, date: Date(), duration: selectedHours, parkingCost: parkingAmount, parkingPlate: plateNumber, suiteNumber: hostSuite)
            
            receiptController.insertReceipt(newReceipt: receipt)
            
            let sbMain: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let receiptVC = sbMain.instantiateViewController(identifier: "ParkingReceiptScene") as! ParkingReceiptVC
            navigationController?.pushViewController(receiptVC, animated: true)
        }
        else{
            showAlert(attempt: false)
        }

    }
    
    func populatePicker() {
        hours = [1, 3, 10, 24]
        parkingCost = [4, 8, 12, 20]
        
        self.pkNumHours.delegate = self
        self.pkNumHours.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.hours.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.hours[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedHours = self.hours[row]
        self.parkingAmount = self.parkingCost[row]
    }
    
    func showAlert(attempt: Bool){
        var msg : String = ""
        msg += "Make sure the License Plate Number is the same as the One you Entered for Your Account\n"
        msg += (txtBuildingCode.text ?? "").count == 0 ? "Building Code Cannot Be Empty\n" : ""
        msg += (txtHostSuite.text ?? "").count == 0 ? "Suite Number Cannot Be Empty\n" : ""


        let alertController = UIAlertController(title: "Add Receipt Attempt", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
