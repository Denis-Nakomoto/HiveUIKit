//
//  ViewController.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 10.09.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper



class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var twoFATextField: UITextField!
    private var textFieldsAreEmpty = false
    var farmsData: [Farm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let _ = KeychainWrapper.standard.removeObject(forKey: "accessToken")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkToken()
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        checkTextFields()
        if let name = loginTextField.text, let password = passwordTextField.text, let tfa = twoFATextField.text {
            if textFieldsAreEmpty {
                NetworkManager.shared.loginRequest(urlString: "https://api2.hiveos.farm/api/v2/auth/login",
                                                   name: name,
                                                   password: password,
                                                   twoFA: tfa) { token in
                    let _ = KeychainWrapper.standard.set(token, forKey: "accessToken")
                    self.checkToken()
                } status: { statusCode in
                    if statusCode == 422 {
                        self.showAlert(with: "ERROR", and: "Name or password is incorrect or 2FA is missing")
                    } else if statusCode == 429 {
                        self.showAlert(with: "ERROR", and: "Too many attemps please try later")
                    }
                }
            } else {
                showAlert(with: "ERROR", and: "Name and password fields are mandatory")
            }
        } else { return }
    }
    
    //MARK: Unwind segue
    @IBAction func unwindSegue(segue: UIStoryboardSegue) { }
    
    //MARK: Alert method
    private func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    //MARK: Check if name and password are filled
    private func checkTextFields() {
        if loginTextField.text != "" || passwordTextField.text != "" {
            textFieldsAreEmpty = true
        } else { textFieldsAreEmpty = false }
    }
    
    //MARK: Check if token is there
    private func checkToken() {
        let retrievedToken = KeychainWrapper.standard.string(forKey: "accessToken")
        if retrievedToken != nil {
            print ("TOKEN IS NOT NIL")
            NetworkManager.shared.fetchFarmData(with: "https://api2.hiveos.farm/api/v2/farms") { farms in
                let farmVC = FarmViewController()
                let vc = UINavigationController(rootViewController: farmVC)
                vc.modalPresentationStyle = .overFullScreen
                farmVC.farms = [farms]
                self.present(vc, animated: true, completion: nil)
            } status: { status in
                if status == 401 {
                    self.showAlert(with: "ERROR", and: "Unauthenticated")
                }
            }
        } else {
            print ("TOKEN IS NOT VALID OR EMPTY")
            let _ = KeychainWrapper.standard.removeObject(forKey: "accessToken")
        }
    }
}

