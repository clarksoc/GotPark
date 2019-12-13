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
    let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let userController = UserController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let em = txtEmail.text ?? ""
        let pw = txtPassword.text ?? ""
        if(em.count == 0 || pw.count == 0 || !userController.validateUser(email: em, password: pw)) {
            showAlert(attempt: false)
        } else {
            let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene") as! HomeVC
            HomeVC.user = userController.getSelectedUser(email: em)!
            navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    func showAlert(attempt: Bool){
        var msg : String = ""
        msg += (txtEmail.text ?? "").count == 0 ? "Email Cannot Be Empty" : ""
        msg += (txtPassword.text ?? "").count == 0 ? "Password Cannot Be Empty" : ""
        msg += !userController.validateUser(email: (txtEmail.text ?? ""), password: (txtPassword.text ?? "")) ? "Email and/or Password Incorrect" : ""
        let alertController = UIAlertController(title: "Login Attempt", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let SignUpVC = mainSB.instantiateViewController(withIdentifier: "SignUpScene") as! SignUpVC
        navigationController?.pushViewController(SignUpVC, animated: true)
    }
}
