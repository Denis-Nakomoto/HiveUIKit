//
//  WorkersInteractor.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright (c) 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class WorkersInteractor: WorkersInteractorProtocol {
    
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
    
    // Calculates height of gpu and icon/hashrate stacks in order to adjust height if header view cell
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int] {
        var result: [Int] = []
        let coin = worker.minersSummary?.hashrates?.count
        var arrangedGpuStackViewQty = Int((worker.gpuStats?.count ?? 0) / 10)
        
        if (worker.gpuStats?.count ?? 0) % 10 != 0 {
            arrangedGpuStackViewQty += 1
        }
        
        result.append(arrangedGpuStackViewQty * 25)
        result.append((coin ?? 0) * 40)
        return result
    }
    
    // Calculates time of work for each worker
    // TODO: It would great to reafactor it
    func convertTime(with value: Int?) -> String {
        
        var bootTime: [String] = []
        
        let interval = Date() - (value!.fromUnixTimeStamp()!)
        
        if let months = interval.month, interval.month != 0 {
            bootTime.append("\(months)M:")
        }
        
        if let days = interval.day, interval.day != 0 {
            if days >= 30 {
                bootTime.append("\(days % 30)d:")
            } else {
                bootTime.append("\(days)d:")
            }
        }
        
        if let hours = interval.hour, interval.hour != 0 {
            if hours >= 24 {
                bootTime.append("\(hours % 24)h:")
            } else {
                bootTime.append("\(hours)h:")
            }
        }
        
        if let minutes = interval.minute, interval.minute != 0 {
            if minutes >= 60 {
                bootTime.append("\(minutes % 60)m")
            } else {
                bootTime.append("\(minutes)m")
            }
        }
        
        return bootTime.joined()
    }
    
    // Converts unix date in normal format
    
    func dateFormatter(from timestamp: String) -> String {
        if let timeInterval = TimeInterval(timestamp) {
            let date = Date(timeIntervalSince1970: timeInterval)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy HH:mm:ss"
            return formatter.string(from: date)
        }
        return ""
    }
    
    // Calculates additional height for short wiew based on the qty of the coins currently in mining
    
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int {
        if let gpuStackHeight = stacksHeights.first, let coinsStackHeight =  stacksHeights.last {
            if gpuStackHeight > 25 && coinsStackHeight > 40 {
                return max(gpuStackHeight, coinsStackHeight)
            }
        } else {
            return 0
        }
        return 0
    }
    
    // Calculates additional height for detailed wiew based on the qty of the GPUs
    
    func prepareDetailedViewHeight(worker: Worker) -> Int {
        var heightAdd = 0
        if let gpuOnline = worker.stats?.gpusOnline {
            let qtyOfStackRows = gpuOnline % 6
            if qtyOfStackRows < 1 {
                heightAdd = 0
            } else if qtyOfStackRows > 1 {
                heightAdd = Int(qtyOfStackRows) * 60
            }
            return heightAdd
        } else { return 0}
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
            CoinsIconsFetchSevice.shared.getIconsForCoinsInUse(with: self.farms!) { result in
                self.iconsImages = result
            }
        }
    }
    
    //Handeles transition to selected rig
    
    func showRigView(rigId: Int, farmId: Int, heightsOfStacks: [Int]) {
        
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
                                                           heightsOfStacks: heightsOfStacks)
                    }
                }
            }
        }
    }
}


