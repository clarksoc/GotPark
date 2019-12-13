//
//  SignInVC.swift
//  GotPark
//
//  Created by Richard Perocho on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    let userController = UserController()
    let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let em = txtEmail.text ?? ""
        let pw = txtPassword.text ?? ""
        do {
        let regexEmail = try NSRegularExpression(pattern: "[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z]", options: [])
            if(em.count == 0 || pw.count == 0 || !userController.validateUser(email: em, password: pw) || regexEmail.firstMatch(in: em, options: [], range: NSMakeRange(0, em.utf16.count)) == nil) {
                showAlert(attempt: false)
            } else {
                let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene") as! HomeVC
                HomeVC.email = em
                navigationController?.pushViewController(homeVC, animated: true)
            }
        }catch{}
    }
    
    func showAlert(attempt: Bool){
        var msg : String = ""
        do {
        let regexEmail = try NSRegularExpression(pattern: "[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z]", options: [])
        msg += (txtEmail.text ?? "").count == 0 ? "Email Cannot Be Empty\n" : ""
        msg += regexEmail.firstMatch(in: (txtEmail.text ?? ""), options: [], range: NSMakeRange(0, (txtEmail.text ?? "").utf16.count)) == nil ? "Email Must Orient in Email Format\n" : ""
        msg += (txtPassword.text ?? "").count == 0 ? "Password Cannot Be Empty\n" : ""
        msg += !userController.validateUser(email: (txtEmail.text ?? ""), password: (txtPassword.text ?? "")) ? "Email and/or Password Incorrect\n" : ""
        }catch{}
        let alertController = UIAlertController(title: "Login Attempt", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let SignUpVC = mainSB.instantiateViewController(withIdentifier: "SignUpScene") as! SignUpVC
        navigationController?.pushViewController(SignUpVC, animated: true)
    }
}
