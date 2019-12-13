//
//  ParkingReceiptListVC.swift
//  GotPark
//
//  Created by Richard Perocho on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit

class ParkingReceiptListVC: UITableViewController {
    
    private var receiptList = [Receipt]()
    let receiptController = ReceiptController()
    let userController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ReceiptList"
        
        let newIndex = receiptList.count
        
        let allReceipts = (receiptController.getAllReceipts() ?? nil)!
        
        // Create new item and add it to the task list
        if (allReceipts != nil){
            for receipts in allReceipts{
                if receipts.value(forKey: "parkPlate") as! String == userController.getSelectedUser(email: HomeVC.email)!.carPlate {
                    let code = receipts.value(forKey: "buildingCode") as! Int
                    let duration = receipts.value(forKey: "duration") as! Int
                    let parkCost = receipts.value(forKey: "parkCost") as! Int
                    let suiteNumber = receipts.value(forKey: "suiteNumber") as! Int
                    let parkPlate = receipts.value(forKey: "parkPlate") as! String
                    let date = receipts.value(forKey: "date") as! Date
                    let usedReceipt = Receipt(buildingCode: code, date: date, duration: duration, parkingCost: parkCost, parkingPlate: parkPlate, suiteNumber: suiteNumber)
                    receiptList.append(usedReceipt)
                }
            }
        }
        
        // Tell the table view a new row has been created
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_receipt", for: indexPath) as! ParkingReceiptListCell
        
        if indexPath.row < receiptList.count
        {
            let receipt = receiptList[indexPath.row]
            cell.lblBuildingCode?.text = "\(receipt.buildingCode)"
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < receiptList.count
        {
            let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = mainSB.instantiateViewController(withIdentifier: "DetailReceiptScene") as! ParkingDetailVC
            
            let receipt = receiptList[indexPath.row]
            detailVC.buildingCode = receipt.buildingCode
            detailVC.duration = receipt.duration
            detailVC.date = receipt.date
            detailVC.parkingCost = receipt.parkingCost
            detailVC.parkPlate = receipt.parkingPlate
            detailVC.suiteNum = receipt.suiteNumber
            
//            detailVC.buildingCode = self.receiptList[indexPath.row].code
//            detailVC.duration = self.receiptList[indexPath.row].duration
//            detailVC.parkingCost = self.receiptList[indexPath.row].parkingCost
//            detailVC.parkPlate = self.receiptList[indexPath.row].company
//            detailVC.jobDescription = self.receiptList[indexPath.row].description

            navigationController?.pushViewController(detailVC, animated: true)

            
        }
    }

}
