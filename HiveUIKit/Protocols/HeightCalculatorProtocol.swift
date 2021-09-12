//
//  HeightCalculatorProtocol.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 07.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

protocol HeightCalculatorProtocol {
    // Calculates additional height for short view based on the qty of the coins currently in mining
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int
    
    // Calculates additional height for detailed wiew based on the qty of the GPUs
    func prepareDetailedViewHeight(worker: Worker) -> Int
    
    // Calculates height of gpu and icon/hashrate stacks in order to adjust height of short view cell in workers module
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
}

extension HeightCalculatorProtocol {
    
    // Calculates additional height for short view based on the qty of the coins currently in mining
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
    
    // Calculates height of gpu and icon/hashrate stacks in order to adjust height of short view cell in workers module
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
    
}
