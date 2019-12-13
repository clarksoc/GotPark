//
//  SignUpVC.swift
//  GotPark
//
//  Created by Richard Perocho on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
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
    }

    @IBAction func btnSignUp(_ sender: Any) {
        let em = txtEmail.text ?? ""
        let pw = txtPassword.text ?? ""
        let fn = txtFirstName.text ?? ""
        let ln = txtLastName.text ?? ""
        let pn = txtPhoneNumber.text ?? ""
        let cp = txtCarPlate.text ?? ""
        let cc = txtCreditCard.text ?? ""
        let ex = txtExpiry.text ?? ""
        let cvv = txtCVV.text ?? ""
        let cn = txtCardName.text ?? ""
        let user = userController.getSelectedUser(email: em)
        do {
        let regexEmail = try NSRegularExpression(pattern: "[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z]", options: [])
        let regexPhone = try NSRegularExpression(pattern: "[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", options: [])
        let regexCreditCard = try NSRegularExpression(pattern: "[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", options: [])
        let regexExpiry = try NSRegularExpression(pattern: "[0-9][0-9]/[0-9][0-9]", options: [])
        let regexCVV = try NSRegularExpression(pattern: "[0-9][0-9][0-9]", options: [])
        
        //regex.firstMatchInString(test, options: [], range: NSMakeRange(0, test.utf16.count)) != nil
            if  user != nil || pw.count == 0 || fn.count == 0 || ln.count == 0 || pn.count == 0 || cp.count != 7 || cc.count == 0 || ex.count == 0 || cvv.count == 0 || cn.count == 0 || regexEmail.firstMatch(in: em, options: [], range: NSMakeRange(0, em.utf16.count)) == nil || regexPhone.firstMatch(in: pn, options: [], range: NSMakeRange(0, pn.utf16.count)) == nil || regexCreditCard.firstMatch(in: cc, options: [], range: NSMakeRange(0, cc.utf16.count)) == nil || regexExpiry.firstMatch(in: ex, options: [], range: NSMakeRange(0, ex.utf16.count)) == nil || regexCVV.firstMatch(in: cvv, options: [], range: NSMakeRange(0, cvv.utf16.count)) == nil {
                showAlert(attempt: false)
            } else {
                let user = User(firstName: fn, lastName: ln, email: em, password: pw, phoneNumber: pn, carPlate: cp)
                let creditCard = CreditCard(email: em, creditCard: cc, expiryDate: ex, cvv: cvv, cardName: cn)
                userController.insertUser(newUser: user)
                creditCardController.insertCreditCard(newCreditCard: creditCard)
                let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene") as! HomeVC
                HomeVC.email = em
                navigationController?.pushViewController(homeVC, animated: true)
            }
        }catch{}
    }
    
    func showAlert(attempt: Bool){
        var msg : String = ""
        let user = userController.getSelectedUser(email: (txtEmail.text ?? ""))
        do {
        let regexEmail = try NSRegularExpression(pattern: "[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z]", options: [])
        let regexPhone = try NSRegularExpression(pattern: "[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", options: [])
        let regexCreditCard = try NSRegularExpression(pattern: "[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", options: [])
        let regexExpiry = try NSRegularExpression(pattern: "[0-9][0-9]/[0-9][0-9]", options: [])
        let regexCVV = try NSRegularExpression(pattern: "[0-9][0-9][0-9]", options: [])
            
        msg += user != nil ? "Email already used\n" : ""
        msg += (txtEmail.text ?? "").count == 0 ? "Email Cannot Be Empty\n" : ""
        msg += regexEmail.firstMatch(in: (txtEmail.text ?? ""), options: [], range: NSMakeRange(0, (txtEmail.text ?? "").utf16.count)) == nil ? "Email Must Orient in Email Format\n" : ""
        msg += (txtPassword.text ?? "").count == 0 ? "Password Cannot Be Empty\n" : ""
        msg += (txtFirstName.text ?? "").count == 0 ? "First Name Cannot Be Empty\n" : ""
        msg += (txtLastName.text ?? "").count == 0 ? "Last Name Cannot Be Empty\n" : ""
        msg += (txtPhoneNumber.text ?? "").count == 0 ? "Phone Number Cannot Be Empty\n" : ""
        msg += regexPhone.firstMatch(in: (txtPhoneNumber.text ?? ""), options: [], range: NSMakeRange(0, (txtPhoneNumber.text ?? "").utf16.count)) == nil ? "Phone Number Must Orient in XXX-XXX-XXXX\n" : ""
        msg += (txtCarPlate.text ?? "").count != 7 ? "Car Plate Must be 7 characters\n" : ""
        msg += (txtCreditCard.text ?? "").count == 0 ? "Credit Card Number Cannot Be Empty\n" : ""
        msg += regexCreditCard.firstMatch(in: (txtCreditCard.text ?? ""), options: [], range: NSMakeRange(0, (txtCreditCard.text ?? "").utf16.count)) == nil ? "CreditCard Must Orient in XXXX-XXXX-XXXX-XXXX\n" : ""
        msg += (txtExpiry.text ?? "").count == 0 ? "Expiry Date Cannot Be Empty\n" : ""
        msg += regexExpiry.firstMatch(in: (txtExpiry.text ?? ""), options: [], range: NSMakeRange(0, (txtExpiry.text ?? "").utf16.count)) == nil ? "Expiry Must Orient in XX/XX\n" : ""
        msg += (txtCVV.text ?? "").count == 0 ? "CVV Cannot Be Empty\n" : ""
        msg += regexCVV.firstMatch(in: (txtCVV.text ?? ""), options: [], range: NSMakeRange(0, (txtCVV.text ?? "").utf16.count)) == nil ? "CVV Must Orient in XXX\n" : ""
        msg += (txtCardName.text ?? "").count == 0 ? "Card Name Cannot Be Empty\n" : ""
        } catch{}
        
        let alertController = UIAlertController(title: "SignUp Attempt", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
