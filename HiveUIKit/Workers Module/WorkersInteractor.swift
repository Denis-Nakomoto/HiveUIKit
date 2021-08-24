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
                bootTime.append("\(minutes)m:")
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
    
    // Pull to fetch and refresh workers view
    
    func refreshWorkers(farmId: Int) {
        let url = "https://api2.hiveos.farm/api/v2/farms/\(farmId)/workers"
        NetworkManager.shared.fetchData(with: url) { [weak self] (result: Workers?, error) in
            guard let workers = result else {
                self?.presenter?.refreshWorkersFailure(with: "ERROR", and: "Loading workers failure. Error: \(String(describing: error)) (Farms interactor)")
                return
            }
            self?.presenter?.refreshWorkersSuccess(workers: workers)
        }
    }
}


