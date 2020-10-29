//
//  NetworkManager.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 28.10.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: Fetch data for farmView and for workerView method
    
    func fetchData(with url: String, farmCompletition: ((_ result: Farm)->())? = nil, workerCompletition: ((_ result: Worker)->())? = nil, status: @escaping(_ statusCode: Int)->()) {
        
        AF.request(url).responseData { (response) in
            guard let statusCode = response.response?.statusCode else { return }
            if (200..<300).contains(statusCode) {
                switch response.result {
                case .success(let data):
                    do {
                        let farm = try JSONDecoder().decode(Farm.self, from: data)
                        let worker = try JSONDecoder().decode(Worker.self, from: data)
                        if let completition = farmCompletition {
                            completition(farm)
                        } else { return }
                        if let completition = workerCompletition {
                            completition(worker)
                        } else { return }
                    }
                    catch let err {
                        print ("ERR \(err)")
                    }
                case .failure (let error):
                    print("ERROR \(error)")
                }
            } else {
                guard let error = response.response?.statusCode else { return }
                status(error)
            }
        }
    }
    
    //MARK: Login method. Returns accessToken
    
    func loginRequest(urlString: String, name: String, password: String, twoFA: String? = nil, completition: @escaping(_ result: String)->(), status: ((_ statusCode: Int)->())? = nil) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        let login = Login(login: name, password: password, twofaCode: twoFA)
        
        AF.request(urlString,
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
                        print ("ERR \(err)")
                    }
                case .failure:
                    if let statusCode = status {
                        statusCode(response.response!.statusCode)
                    } else { return }
                }
            }
    }
    
    //MARK: Method for reset password handeling
    
    func resetPassword(with email: String) {
        
    }
}





