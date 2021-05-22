//
//  LoginContract.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 23.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }

    func didGetFarmsFailure(with error: String, and message: String)
    
    func dismissVC()
}

protocol LoginInteractorProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    
    func checkTextFields(name: String, password: String, twoFa: String?)
    func getAccessToken()
    func getFarms()
    func checkTokenIsNil()
}

protocol LoginPresenterProtocol: class {
    var router: LoginRouterProtocol? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    var view: LoginViewProtocol? { get set}
    
    func signIn(name: String, password: String, twoFa: String?)
    func signUp()
    func forgetPassword()
    func fetchFarmsSuccess(farms: Farms)
    func fetchFarmsFailure(with error: String, and message: String)
    func viewDidLoad()
}

protocol LoginRouterProtocol: class {
    static func createLoginModule() -> UIViewController
    
    func pushToFarmsModule(on view: LoginViewProtocol, with farms: Farms)
//    func presentSignUpModule()
//    func presentForgetPasswordModule()
}
