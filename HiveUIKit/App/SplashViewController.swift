//
//  SplashViewController.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 02.05.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SplashViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        
        activityIndicator.startAnimating()
        
        let accessToken = KeychainWrapper.standard.string(forKey: "accessToken")
        if accessToken != nil {
            let url = "https://api2.hiveos.farm/api/v2/farms"
            NetworkManager.shared.fetchData(with: url) { (result: Farms?, error) in
// TODO: Handle long fenching or connection absance
                
//                if let error = error {
//                    self.showAlert(with:"Error", and:"Something went wrong, check internet connection \(error)")
//                }
                if let farms = result {
                    SceneDelegate.shared.rootViewController.prepareForSwitchToFarm(with: farms)
                    self.activityIndicator.stopAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                    SceneDelegate.shared.rootViewController.showLoginScreen()
                }
            }
        } else {
            SceneDelegate.shared.rootViewController.showLoginScreen()
        }
    }
    
    deinit {
        print("Splash view is deallocated")
    }
}
