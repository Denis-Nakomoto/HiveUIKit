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
    func loginRequest(name: String, password: String, twoFA: String? = nil, completition: @escaping(_ result: String)->(), status: ((_ statusCode: Int)->())? = nil) {
        
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
                        completition(token.accessToken ?? "")
                    }
                    catch let err {
                        print ("ENCODING ERROR \(err)")
                    }
                case .failure:
                    if let statusCode = status {
                        statusCode(response.response!.statusCode)
                    } else { return }
                }
            }
    }
    
    //MARK: - Fetch data for farm view
    func fetchFarmData(with url: String, completition: @escaping((_ result: Farms)->()), status: ((_ statusCode: Int)->())? = nil) {
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
                        print ("SUCCESS")
                        do {
                            let farms = try JSONDecoder().decode(Farms.self, from: data)
                            completition(farms)
                        }
                        catch let err {
                            print ("ENCOIDNG ERROR \(err)")
                        }
                    case .failure (let error):
                        print("AF REQUEST FAILURE \(error)")
                    }
                } else {
                    guard let error = response.response?.statusCode else { return }
                    guard let status = status else { return }
                    status(error)
                }
            }
    }
    
    //MARK: - Fetch data for workers view
    func fetchWorkerData(with url: String, completition: @escaping((_ result: Worker)->()), status: ((_ statusCode: Int)->())? = nil) {
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
                        print ("SUCCESS")
                        do {
                            let workers = try JSONDecoder().decode(Worker.self, from: data)
                            completition(workers)
                        }
                        catch let err {
                            let dataString = String(decoding: data, as: UTF8.self)
                            print("Workers data: \(dataString)")
                            print ("ENCOIDNG ERROR \(err)")
                        }
                    case .failure (let error):
                        print("AF REQUEST FAILURE \(error)")
                    }
                } else {
                    guard let error = response.response?.statusCode else { return }
                    guard let status = status else { return }
                    status(error)
                }
            }
    }
    
    func fetchData<T: Decodable>(with url: String, completition: @escaping(_ result: T?, _ error: String?)->()) {
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
                        print ("SUCCESS")
                        let dataString = String(decoding: data, as: UTF8.self)
                        print("Workers data: \(dataString)")
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
                    print("AF REQUEST FAILURE: \(response.response?.statusCode)")
                }
            }
    }
}
