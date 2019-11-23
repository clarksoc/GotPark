//
//  CustomerSupport.swift
//  GotPark
//
//  Created by Connor Clarkson on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit

class CustomerSupportVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func supportEmailClick(){
        let email = "GotParkCustomerSupport@park.ca"
        
        let url = URL(string: "mailto:\(email)")!
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    

    @IBAction func supportPhoneClick(){
        let phone = 18004687275
        
        let url = URL(string: "tel://\(phone)")!
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}
