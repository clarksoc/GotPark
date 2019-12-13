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
        do {
        let regexPhone = try NSRegularExpression(pattern: "[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", options: [])
        let regexCreditCard = try NSRegularExpression(pattern: "[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", options: [])
        let regexExpiry = try NSRegularExpression(pattern: "[0-9][0-9]/[0-9][0-9]", options: [])
        let regexCVV = try NSRegularExpression(pattern: "[0-9][0-9][0-9]", options: [])
        
        //regex.firstMatchInString(test, options: [], range: NSMakeRange(0, test.utf16.count)) != nil
            if  pw.count == 0 || fn.count == 0 || ln.count == 0 || pn.count == 0 || cp.count != 7 || cc.count == 0 || ex.count == 0 || cvv.count == 0 || cn.count == 0 || regexPhone.firstMatch(in: pn, options: [], range: NSMakeRange(0, pn.utf16.count)) != nil || regexCreditCard.firstMatch(in: cc, options: [], range: NSMakeRange(0, cc.utf16.count)) != nil || regexExpiry.firstMatch(in: ex, options: [], range: NSMakeRange(0, ex.utf16.count)) != nil || regexCVV.firstMatch(in: cvv, options: [], range: NSMakeRange(0, cvv.utf16.count)) != nil {
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
        }catch{}
    }
    
    func showAlert(attempt: Bool){
        var msg : String = ""
        do {
        let regexPhone = try NSRegularExpression(pattern: "[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", options: [])
        let regexCreditCard = try NSRegularExpression(pattern: "[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", options: [])
        let regexExpiry = try NSRegularExpression(pattern: "[0-9][0-9]/[0-9][0-9]", options: [])
        let regexCVV = try NSRegularExpression(pattern: "[0-9][0-9][0-9]", options: [])
            
        msg += (txtPassword.text ?? "").count == 0 ? "Password Cannot Be Empty" : ""
        msg += (txtFirstName.text ?? "").count == 0 ? "First Name Cannot Be Empty" : ""
        msg += (txtLastName.text ?? "").count == 0 ? "Last Name Cannot Be Empty" : ""
        msg += (txtPhoneNumber.text ?? "").count == 0 ? "Phone Number Cannot Be Empty" : ""
        msg += regexPhone.firstMatch(in: (txtPhoneNumber.text ?? ""), options: [], range: NSMakeRange(0, (txtPhoneNumber.text ?? "").utf16.count)) != nil ? "Phone Number Must Orient in XXX-XXX-XXXX" : ""
        msg += (txtCarPlate.text ?? "").count != 7 ? "Car Plate Must be 7 characters" : ""
        msg += (txtCreditCard.text ?? "").count == 0 ? "Credit Card Number Cannot Be Empty" : ""
        msg += regexCreditCard.firstMatch(in: (txtCreditCard.text ?? ""), options: [], range: NSMakeRange(0, (txtCreditCard.text ?? "").utf16.count)) != nil ? "CreditCard Must Orient in XXXX-XXXX-XXXX-XXXX" : ""
        msg += (txtExpiry.text ?? "").count == 0 ? "Expiry Date Cannot Be Empty" : ""
        msg += regexExpiry.firstMatch(in: (txtExpiry.text ?? ""), options: [], range: NSMakeRange(0, (txtExpiry.text ?? "").utf16.count)) != nil ? "Expiry Must Orient in XX/XX" : ""
        msg += (txtCVV.text ?? "").count == 0 ? "CVV Cannot Be Empty" : ""
        msg += regexCVV.firstMatch(in: (txtCVV.text ?? ""), options: [], range: NSMakeRange(0, (txtCVV.text ?? "").utf16.count)) != nil ? "CVV Must Orient in XXX" : ""
        msg += (txtCardName.text ?? "").count == 0 ? "Card Name Cannot Be Empty" : ""
        }catch{}
        let alertController = UIAlertController(title: "SignUp Attempt", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
