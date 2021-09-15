//
//  WorkersInteractor.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright (c) 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class WorkersInteractor: WorkersInteractorProtocol, DatePrepareableProtocol, HeightCalculatorProtocol {
    
    var presenter: WorkersPresenterProtocol?
    
    var farms: Farms?
    var workers: Workers?
    var selectedFarm: Farm?
    var mestrics: MetricsModel?
    var messages: MessagesModel?
    
    var iconsImages = [String : UIImage]()
    {
        didSet {
            print(iconsImages)
            DispatchQueue.main.async { [weak self] in
                if let wrkr = self?.workers, let frm = self?.selectedFarm {
                    self?.presenter?.refreshWorkersSuccess(workers: wrkr, farm: frm)
                }
                else { return }
            }
        }
    }
    
    // Pull to fetch and refresh workers view
    func refreshWorkers(farmId: Int) {
        
        let group = DispatchGroup()
        // ulr - workers refresh
        // url1 - all farms refresh, done to refresh icon and total farm hashrate
        // url2 - to refresh header which shows gereral info for selected farm
        let url = "https://api2.hiveos.farm/api/v2/farms/\(farmId)/workers"
        let url1 = "https://api2.hiveos.farm/api/v2/farms"
        let url2 = "https://api2.hiveos.farm/api/v2/farms/\(farmId)"
        group.enter()
        NetworkManager.shared.fetchData(with: url) { [weak self] (result: Workers?, error) in
            defer { group.leave() }
            guard let resultWorkers = result else {
                self?.presenter?.refreshWorkersFailure(with: "ERROR", and: "Loading workers failure. Error: \(String(describing: error)) (Workers interactor)")
                return
            }
            self?.workers = resultWorkers
        }
        group.enter()
        NetworkManager.shared.fetchData(with: url1) { [weak self] (result: Farms?, error) in
            defer { group.leave() }
            guard let resultFarms = result else {
                self?.presenter?.refreshWorkersFailure(with: "ERROR", and: "Loading coins failure. Error: \(String(describing: error)) (Workers interactor)")
                return
            }
            self?.farms = resultFarms
        }
        group.enter()
        NetworkManager.shared.fetchData(with: url2) { [weak self] (result: Farm?, error) in
            defer { group.leave() }
            guard let selectedFarm = result else {
                self?.presenter?.refreshWorkersFailure(with: "ERROR", and: "Loading farm info failure. Error: \(String(describing: error)) (Workers interactor)")
                return
            }
            self?.selectedFarm = selectedFarm
        }
        group.notify(queue: .global()) {
            if self.farms == nil {
                self.presenter?.refreshWorkersFailure(with: "ERROR", and: "Refresh workers failure.")
            } else {
                CoinsIconsFetchSevice.shared.getIconsForCoinsInUse(with: self.farms!) { result in
                    self.iconsImages = result
                }
            }
        }
    }
    
    //Handeles transition to selected rig
    func showRigView(rigId: Int, farmId: Int, icons: [String : UIImage]) {
        
        let group = DispatchGroup()
        let url = "https://api2.hiveos.farm/api/v2/farms/\(farmId)/workers"
        let url1 = "https://api2.hiveos.farm/api/v2/farms/\(farmId)/workers/\(rigId)/messages"
        let url2 = "https://api2.hiveos.farm/api/v2/farms/\(farmId)/workers/\(rigId)/metrics"
        group.enter()
        NetworkManager.shared.fetchData(with: url) { [weak self] (result: Workers?, error) in
            defer { group.leave() }
            guard let resultWorkers = result else { return }
            self?.workers = resultWorkers
        }
        
        group.enter()
        NetworkManager.shared.fetchData(with: url1) { [weak self] (result: MessagesModel?, error) in
            defer { group.leave() }
            guard let resultMessages = result else { return }
            self?.messages = resultMessages
        }
        
        group.enter()
        NetworkManager.shared.fetchData(with: url2) { [weak self] (result: MetricsModel?, error) in
            defer { group.leave() }
            guard let resultMetrics = result else { return }
            self?.mestrics = resultMetrics
        }
        
        group.notify(queue: .main) {
            if let workers = self.workers?.data, let mtr = self.mestrics, let msgs = self.messages {
                for item in workers {
                    if item.id == rigId {
                        self.presenter?.showRigViewSuccess(rig: item,
                                                           metrics: mtr,
                                                           messages: msgs,
                                                           icons: icons)
                    }
                }
            }
        }
    }
}


