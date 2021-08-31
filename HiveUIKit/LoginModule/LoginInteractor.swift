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
    
    func checkTextFields(name: String, password: String, twoFa: String?) {
            if name == "" || password == "" {
                presenter?.fetchFarmsFailure(with: "ERROR", and: "Name and password are mandatory")
                return
            } else {
            self.name = name
            self.password = password
            self.twoFa = twoFa ?? ""
            self.getAccessToken()
            }
        }
    
    func getAccessToken() {
            NetworkManager.shared.loginRequest(name: name,
                                               password: password,
                                               twoFA: twoFa) { [weak self] token, error in
                guard let error = error else {
                    let _ = KeychainWrapper.standard.set(token, forKey: "accessToken")
                    self?.getFarms()
                    return
                }
                self?.presenter?.fetchFarmsFailure(with: "ERROR", and: "\(error)")
            }
    }

    func getFarms() {
        let url = "https://api2.hiveos.farm/api/v2/farms"
        NetworkManager.shared.fetchData(with: url) { [weak self] (result: Farms?, error) in
            guard let farms = result else {
                self?.presenter?.fetchFarmsFailure(with: "ERROR", and: "Cannot fetch farms \(error!)")
                return
            }
            self?.presenter?.fetchFarmsSuccess(farms: farms)
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
