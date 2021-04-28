//
//  LoginInteractor.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 23.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class LoginInteractor: LoginInteractorProtocol {
    
    var presenter: LoginPresenterProtocol?
    
    var name = ""
    var password = ""
    var twoFa = ""
    
    func checkTextFields(name: String?, password: String?, twoFa: String?) {
        print(#function)
            guard let name = name, let password = password else {
                presenter?.fetchFarmsFailure(with: "ERROR", and: "Name and password are mandatory")
                return
            }
            self.name = name
            self.password = password
            self.twoFa = twoFa ?? ""
            self.getAccessToken()
        }
    
    func getAccessToken() {
        print(#function)
            NetworkManager.shared.loginRequest(name: name,
                                               password: password,
                                               twoFA: twoFa) { token in
                let _ = KeychainWrapper.standard.set(token, forKey: "accessToken")
                self.getFarms()
            } status: { statusCode in
                print("CODE: \(statusCode)")
                if statusCode == 422 {
                    self.presenter?.fetchFarmsFailure(with: "ERROR", and: "Name or password is incorrect or 2FA is missing")
                } else if statusCode == 429 {
                    self.presenter?.fetchFarmsFailure(with: "ERROR", and: "Too many attemps please try later")
                } else if (200..<300).contains(statusCode) {
                }
            }
    }

    func getFarms(){
        print(#function)
        NetworkManager.shared.fetchData(with: "https://api2.hiveos.farm/api/v2/farms") { (result: Farms?,
                                                                                          error) in
            guard let farms = result else {
                self.presenter?.fetchFarmsFailure(with: "ERROR", and: "Cannot fetch farms \(error!)")
                return
            }
            self.presenter?.fetchFarmsSuccess(farms: farms)
        }
    }
    
    func checkTokenIsNil() {
        let currentToken = KeychainWrapper.standard.string(forKey: "accessToken")
        if currentToken != nil {
            getFarms()
            presenter?.view?.dismissVC()
        } else { return }
    }
}
