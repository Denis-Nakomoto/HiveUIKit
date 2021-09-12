//
//  NetworkManager.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 28.10.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Login method. Returns accessToken
    func loginRequest(name: String, password: String, twoFA: String? = nil, completition: @escaping(_ result: String, _ error: Error?)->()) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        let login = Login(login: name, password: password, twofaCode: twoFA)
        
        AF.request("https://api2.hiveos.farm/api/v2/auth/login",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success (let data):
                    do {
                        let token = try JSONDecoder().decode(Login.self, from: data)
                        completition(token.accessToken ?? "", nil)
                    }
                    catch let error {
                        print ("ENCODING ERROR \(error)")
                        completition("", error)
                    }
                case .failure (let error):
                    completition("", error)
                }
            }
    }
    
    func fetchData<T: Decodable>(with url: String, completition: @escaping(_ result: T?, _ error: String?)->(), status: ((_ statusCode: Int)->())? = nil) {
        print(#function)
        let accessToken = KeychainWrapper.standard.string(forKey: "accessToken")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken ?? "")",
            "Accept": "application/json"
        ]
        
        AF.request(url,
                   method: .get,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                guard let statusCode = response.response?.statusCode else { return }
                if (200..<300).contains(statusCode) {
                    switch response.result {
                    case .success(let data):
                        //                        print ("SUCCESS")
//                                                let dataString = String(decoding: data, as: UTF8.self)
                        //                        status!(statusCode)
//                                                print("JSON: \(dataString)")
                        do {
                            let farms = try JSONDecoder().decode(T.self, from: data)
                            completition(farms, nil)
                        }
                        catch let err {
                            print ("ENCOIDNG ERROR \(err)")
                            completition(nil, err.localizedDescription)
                        }
                    case .failure (let error):
                        print("AF REQUEST FAILURE \(error)")
                        completition(nil, error.localizedDescription)
                    }
                } else {
                    print("AF REQUEST FAILURE: \(String(describing: response.response?.statusCode))")
                    completition(nil, "Request failure: \(String(describing: response.response?.statusCode))")
                }
            }
    }
    
    // TEST of token refresh TEMP
    
    func tokenRefresh(completition: @escaping(_ result: String, _ error: Error?)->()) {
        
        let accessToken = KeychainWrapper.standard.string(forKey: "accessToken")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken ?? "")",
            "Accept": "application/json"
        ]
        
        AF.request("https://api2.hiveos.farm/api/v2/auth/refresh",
                   method: .post,
                   parameters: "",
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success (let data):
                    do {
                        let token = try JSONDecoder().decode(Login.self, from: data)
                        completition(token.accessToken ?? "", nil)
                    }
                    catch let error {
                        print ("ENCODING ERROR \(error)")
                    }
                case .failure (let error):
                    print("refresh error: \(error)")
                }
            }
    }
    
    
    // Get entityes TEMP
    
    func getEntity(with url: String) {
        let accessToken = KeychainWrapper.standard.string(forKey: "accessToken")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken ?? "")",
            "Accept": "application/json"
        ]
        
        AF.request(url,
                   method: .get,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                guard let statusCode = response.response?.statusCode else { return }
                if (200..<300).contains(statusCode) {
                    switch response.result {
                    case .success(let data):
                        //                        print ("SUCCESS")
                        let dataString = String(decoding: data, as: UTF8.self)
                        //                        status!(statusCode)
                        print("METRICS: \(dataString)")
                    //                    do {
                    //                        let farms = try JSONDecoder().decode(T.self, from: data)
                    //                        completition(farms, nil)
                    //                    }
                    //                    catch let err {
                    //                        print ("ENCOIDNG ERROR \(err)")
                    //                    }
                    case .failure (let error):
                        print("AF REQUEST FAILURE \(error)")
                    }
                } else {
                    print("AF REQUEST FAILURE: \(String(describing: response.response?.statusCode))")
                }
            }
    }
    

//WS test temp
    func webSocket() {
        let url = "https://api2.hiveos.farm/api/v2/farms"
        let accessToken = KeychainWrapper.standard.string(forKey: "accessToken")
        print(accessToken)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken ?? "")",
            "Accept": "application/json",
            "Upgrade": "WebSocket",
            "Connection": "Upgrade"
        ]
        
        AF.request(url,
                   method: .get,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                guard let statusCode = response.response?.statusCode else { return }
                if (200..<300).contains(statusCode) {
                    switch response.result {
                    case .success(let data):
                        print ("SUCCESS")
                        let dataString = String(decoding: data, as: UTF8.self)
                        print(dataString)
                        //                        status!(statusCode)
                    //                    do {
                    //                        let farms = try JSONDecoder().decode(T.self, from: data)
                    //                        completition(farms, nil)
                    //                    }
                    //                    catch let err {
                    //                        print ("ENCOIDNG ERROR \(err)")
                    //                    }
                    case .failure (let error):
                        print("AF REQUEST FAILURE \(error)")
                    }
                } else {
                    print("AF REQUEST FAILURE: \(String(describing: response.response?.statusCode))")
                }
            }
    }
    
}

