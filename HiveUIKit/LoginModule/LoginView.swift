//
//  LoginView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 23.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class LoginView: UIViewController, LoginViewProtocol {
    
    weak var presenter: LoginPresenterProtocol?
    
    let hiveLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "HiveLogo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let nameTextField = UITextField(string: "Name or e-mail")
    
    let passwordTextField = UITextField(string: "Your password", isSecure: true)
    
    let twoFaTextField = UITextField(string: "Two FA if enabled")
    
    let singnInButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor =  #colorLiteral(red: 0, green: 0.6466762424, blue: 1, alpha: 1)
        button.setTitle("Sign In", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar() 
        presenter?.viewDidLoad()
        singnInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        nameTextField.delegate = self
        passwordTextField.delegate = self
        twoFaTextField.delegate = self
    }
    
    @objc func signIn() {
        presenter?.signIn(name: nameTextField.text ?? "", password: passwordTextField.text ?? "", twoFa: twoFaTextField.text)
    }
    
    func didGetFarmsFailure(with error: String, and message: String) {
        self.showAlert(with: error, and: message)
    }
    
    // Remove it from protocol and here
    func dismissVC() {
        self.dismiss(animated: false)
    }
    
    deinit {
        print("Login VC is deallocated")
    }
}

extension LoginView {
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .black
        overrideUserInterfaceStyle = .dark
        view.addSubview(hiveLogo)
        view.addSubview(nameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(twoFaTextField)
        view.addSubview(singnInButton)
        
        hiveLogo.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        twoFaTextField.translatesAutoresizingMaskIntoConstraints = false
        singnInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hiveLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 8),
            hiveLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hiveLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hiveLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.topAnchor.constraint(equalTo: hiveLogo.bottomAnchor, constant: 60),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            twoFaTextField.heightAnchor.constraint(equalToConstant: 40),
            twoFaTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            twoFaTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            twoFaTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            twoFaTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            singnInButton.heightAnchor.constraint(equalToConstant: 40),
            singnInButton.topAnchor.constraint(equalTo: twoFaTextField.bottomAnchor, constant: 40),
            singnInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            singnInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            singnInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}

// Text fields delegate

extension LoginView: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            twoFaTextField.becomeFirstResponder()
        } else {
            signIn()
        }
        return true
    }
}
