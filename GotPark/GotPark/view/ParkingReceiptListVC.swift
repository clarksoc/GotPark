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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ReceiptList"
        
        let newIndex = receiptList.count
        
        let allReceipts = (receiptController.getAllReceipts() ?? nil)!
        
        // Create new item and add it to the task list
        if (allReceipts != nil){
            for receipts in allReceipts{
                let code = task.value(forKey: "buildingCode") as! Integer64
                let duration = task.value(forKey: "duration") as! Integer64
                let parkCost = task.value(forKey: "parkCost") as! Integer64
                let suiteNumber = task.value(forKey: "suiteNumber") as! Integer64
                let parkPlate = task.value(forKey: "parkPlate") as! Integer64
                let date = task.value(forKey: "date") as! Date
                var usedReceipt = Receipt(buildingCode: code, date: date, duration: duration, parkingCost: parkCost, parkingPlate: parkPlate, suiteNumber: suiteNumber)
                receiptList.append(usedReceipt)
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

}
