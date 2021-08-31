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
        let group = DispatchGroup()
        var loadedWorkers: Workers?
        var loadedFarm: Farm?
        let url = "https://api2.hiveos.farm/api/v2/farms/\(farmId)/workers"
        let url1 = "https://api2.hiveos.farm/api/v2/farms/\(farmId)"
        group.enter()
        NetworkManager.shared.fetchData(with: url) { [weak self] (result: Workers?, error) in
            defer { group.leave() }
            guard let workers = result else {
                self?.presenter?.fetchWorkersFailure(with: "ERROR", and: "Loading workers failure. Error: \(String(describing: error)) (Farms interactor)")
                return
            }
            loadedWorkers = workers
        }
        group.enter()
        NetworkManager.shared.fetchData(with: url1) { [weak self] (result: Farm?, error) in
            defer { group.leave() }
            guard let farm = result else {
                self?.presenter?.fetchWorkersFailure(with: "ERROR", and: "Loading workers failure. Error: \(String(describing: error)) (Farms interactor)")
                return
            }
            loadedFarm = farm
        }
        group.notify(queue: .main) {
            if let wrks = loadedWorkers, let frm = loadedFarm {
                self.presenter?.fetchWorkersSuccess(workers: wrks, farmId: farmId, farmSelected: frm)
            }
        }
    }
    
    func logOut() {
        let _ = KeychainWrapper.standard.removeObject(forKey: "accessToken")
        SceneDelegate.shared.rootViewController.switchToLogout()
    }
}
