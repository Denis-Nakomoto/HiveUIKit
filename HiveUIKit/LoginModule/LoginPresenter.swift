//
//  LoginPresenter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 23.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    
    var router: LoginRouterProtocol?
    
    var interactor: LoginInteractorProtocol?
    
    weak var view: LoginViewProtocol?
    
    func viewDidLoad() {
        interactor?.checkTokenIsNil()
    }
    
    func signIn(name: String, password: String, twoFa: String?) {
        interactor?.checkTextFields(name: name, password: password, twoFa: twoFa)
    }
    
    func fetchFarmsSuccess(farms: Farms) {
        router?.pushToFarmsModule(on: view!, with: farms)
    }
    
    func fetchFarmsFailure(with error: String, and message: String) {
        view?.didGetFarmsFailure(with: error, and: message)
    }
    
    func signUp() {
        
    }
    
    func forgetPassword() {
        
    }
}
