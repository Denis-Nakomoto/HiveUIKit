//
//  FarmsInteractor.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 21.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class FarmsInteractor: FarmsInteractorProtocol {
    
    var presenter: FarmsPresenterProtocol?
    
    func loadWorkers(with farmId: Int) {
        let url = "https://api2.hiveos.farm/api/v2/farms/\(farmId)/workers"
        NetworkManager.shared.fetchData(with: url) { [weak self] (result: Workers?, error) in
            guard let workers = result else {
                self?.presenter?.fetchWorkersFailure(with: "ERROR", and: "Loading workers failure. Error: \(String(describing: error)) (Farms interactor)")
                return
            }
            self?.presenter?.fetchWorkersSuccess(workers: workers, farmId: farmId)
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "CoinsCache")
        let _ = KeychainWrapper.standard.removeObject(forKey: "accessToken")
        SceneDelegate.shared.rootViewController.switchToLogout()
    }
}
