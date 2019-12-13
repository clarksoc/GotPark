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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnLogin(_ sender: Any) {
        let em = txtEmail.text ?? ""
        let pw = txtPassword.text ?? ""
        if(em.count == 0 || pw.count == 0 || !userController.validateUser(email: em, password: pw)) {
            showAlert(attempt: false)
        } else {
            //goto map
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
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SignUpVC = mainSB.instantiateViewController(withIdentifier: "SignUpScene") as! SignUpVC
        navigationController?.pushViewController(SignUpVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
