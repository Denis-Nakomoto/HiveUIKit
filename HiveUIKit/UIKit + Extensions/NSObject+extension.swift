//
//  UIScrollView+extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

extension NSObject {
    
    func composeStackOfGpus(with worker: Worker) -> UIStackView {
        
        let group = DispatchGroup()
        let resultStackOfGpus = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 8)
        var arrangedViewQty = Int((worker.gpuStats?.count ?? 0) / 10)
        
        if worker.gpuStats?.count ?? 0 % 10 != 0 {
            arrangedViewQty += 1
        }
        
        group.enter()
        for arrView in 0..<arrangedViewQty {
            let gpuContainerView = GpuContainerView(frame: CGRect(x: 0, y: 0, width: 220, height: 45))
            var spacing: CGFloat = 0
            var arraySlice: ArraySlice<GPUStat> = []
            
            if arrangedViewQty == 1 {
                arraySlice = (worker.gpuStats?[0...])!
            } else if arrView > 1, arrView != arrangedViewQty - 1 {
                arraySlice = (worker.gpuStats?[arrView * 10...(arrView * 10) + 9])!
            } else if arrView == arrangedViewQty - 1 {
                arraySlice = (worker.gpuStats?[(arrView * 10)...])!
            }
            
            arraySlice.forEach({ gpu in
                if gpu.power == 0 {
                    gpuContainerView.setupEachGpuView(spacing: spacing, backgroundColor: .clear, borderColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
                    spacing -= 19
                } else if gpu.isOverheated ?? false {
                    gpuContainerView.setupEachGpuView(height: 17, width: 21, spacing: spacing, backgroundColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), borderColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
                    spacing -= 25
                } else {
                    gpuContainerView.setupEachGpuView(spacing: spacing)
                    spacing -= 19
                }
            })
            resultStackOfGpus.addArrangedSubview(gpuContainerView.view)
        }
        group.leave()
        group.wait()
        return resultStackOfGpus
    }
    
}
