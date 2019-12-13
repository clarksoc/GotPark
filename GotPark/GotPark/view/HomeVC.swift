//
//  HomeVC.swift
//  GotPark
//
//  Created by Richard Perocho on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    static var user = User(firstName: "", lastName: "", email: "", password: "", phoneNumber: "", carPlate: "")
    let sbMain : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addClick(_ sender: Any) {
        let newVC = sbMain.instantiateViewController(withIdentifier: "NewScene") as! NewParkingVC
        
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func viewReceiptClick(_ sender: Any) {
        let parkingVC = sbMain.instantiateViewController(withIdentifier: "ParkingReceiptScene") as! ParkingReceiptVC
        
        navigationController?.pushViewController(parkingVC, animated: true)
    }
    
    @IBAction func viewReceiptList(_ sender: Any) {
        let parkingListVC = sbMain.instantiateViewController(withIdentifier: "ParkingReceiptListScene") as! ParkingReceiptListVC
        
        navigationController?.pushViewController(parkingListVC, animated: true)
    }
    
    @IBAction func nearbyClick(_ sender: Any) {
        let nearbyVC = sbMain.instantiateViewController(withIdentifier: "NearbyScene") as! LocateNearbyParkingVC
        
        navigationController?.pushViewController(nearbyVC, animated: true)
    }
    
    
    @IBAction func manualClick(_ sender: Any) {
            let manualVC = sbMain.instantiateViewController(withIdentifier: "ManualScene") as! AppManualVC
            
            navigationController?.pushViewController(manualVC, animated: true)
    }
    
    @IBAction func supportClick(_ sender: Any) {
        let supportVC = sbMain.instantiateViewController(withIdentifier: "SupportScene") as! CustomerSupportVC
        
        navigationController?.pushViewController(supportVC, animated: true)
    }
    @IBAction func btnSignOut(_ sender: Any) {
        let signInVC = sbMain.instantiateViewController(withIdentifier: "SignInScene") as! SignInVC
        
        navigationController?.pushViewController(signInVC, animated: true)
    }
}
