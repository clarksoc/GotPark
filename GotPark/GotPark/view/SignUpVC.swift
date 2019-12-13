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
        if user != nil || em.count == 0 || pw.count == 0 || fn.count == 0 || ln.count == 0 || pn.count == 0 || cp.count == 0 || cc.count == 0 || ex.count == 0 || cvv.count == 0 || cn.count == 0 {
            showAlert(attempt: false)
        } else {
            let user = User(firstName: fn, lastName: ln, email: em, password: pw, phoneNumber: pn, carPlate: cp)
            let creditCard = CreditCard(email: em, creditCard: cc, expiryDate: ex, cvv: cvv, cardName: cn)
            userController.insertUser(newUser: user)
            creditCardController.insertCreditCard(newCreditCard: creditCard)
            let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene") as! HomeVC
            HomeVC.user = user
            navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    func showAlert(attempt: Bool){
        var msg : String = ""
        let user = userController.getSelectedUser(email: (txtEmail.text ?? ""))
        msg += user != nil ? "Email already used" : ""
        msg += (txtEmail.text ?? "").count == 0 ? "Email Cannot Be Empty" : ""
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
