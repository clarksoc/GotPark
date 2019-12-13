//
//  EditVC.swift
//  GotPark
//
//  Created by Adrian Gonzalez Madruga on 2019-12-13.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import Foundation
import UIKit
class EditVC: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtCarPlate: UITextField!
    @IBOutlet weak var txtCreditCard: UITextField!
    @IBOutlet weak var txtExpiry: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var txtCardName: UITextField!
    let userController = UserController()
    let creditCardController = CreditCardController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = userController.getSelectedUser(email: HomeVC.email)!
        let creditCard = creditCardController.getSelectedCreditCard(email: HomeVC.email)!
        txtFirstName.text = user.firstName
        txtLastName.text = user.lastName
        txtPassword.text = user.password
        txtPhoneNumber.text = user.phoneNumber
        txtCarPlate.text = user.carPlate
        txtCreditCard.text = creditCard.creditCard
        txtExpiry.text = creditCard.expiryDate
        txtCVV.text = creditCard.cvv
        txtCardName.text = creditCard.cardName
        
    }

    @IBAction func btnEdit(_ sender: Any) {
        let pw = txtPassword.text ?? ""
        let fn = txtFirstName.text ?? ""
        let ln = txtLastName.text ?? ""
        let pn = txtPhoneNumber.text ?? ""
        let cp = txtCarPlate.text ?? ""
        let cc = txtCreditCard.text ?? ""
        let ex = txtExpiry.text ?? ""
        let cvv = txtCVV.text ?? ""
        let cn = txtCardName.text ?? ""
        if  pw.count == 0 || fn.count == 0 || ln.count == 0 || pn.count == 0 || cp.count == 0 || cc.count == 0 || ex.count == 0 || cvv.count == 0 || cn.count == 0 {
            showAlert(attempt: false)
        } else {
            let user = User(firstName: fn, lastName: ln, email: HomeVC.email, password: pw, phoneNumber: pn, carPlate: cp)
            let creditCard = CreditCard(email: HomeVC.email, creditCard: cc, expiryDate: ex, cvv: cvv, cardName: cn)
            userController.updateUser(user: user, oldEmail: HomeVC.email)
            creditCardController.updateCreditCard(creditCard: creditCard, oldEmail: HomeVC.email)
            let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene") as! HomeVC
            navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    func showAlert(attempt: Bool){
        var msg : String = ""
        msg += (txtPassword.text ?? "").count == 0 ? "Password Cannot Be Empty" : ""
        msg += (txtFirstName.text ?? "").count == 0 ? "First Name Cannot Be Empty" : ""
        msg += (txtLastName.text ?? "").count == 0 ? "Last Name Cannot Be Empty" : ""
        msg += (txtPhoneNumber.text ?? "").count == 0 ? "Phone Number Cannot Be Empty" : ""
        msg += (txtCarPlate.text ?? "").count == 0 ? "Car Plate Cannot Be Empty" : ""
        msg += (txtCreditCard.text ?? "").count == 0 ? "Credit Card Number Cannot Be Empty" : ""
        msg += (txtExpiry.text ?? "").count == 0 ? "Expiry Date Cannot Be Empty" : ""
        msg += (txtCVV.text ?? "").count == 0 ? "CVV Cannot Be Empty" : ""
        msg += (txtCardName.text ?? "").count == 0 ? "Card Name Cannot Be Empty" : ""
        
        let alertController = UIAlertController(title: "SignUp Attempt", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
