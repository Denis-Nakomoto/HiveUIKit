//
//  DetailedWorkerView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 16.06.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class DetailedWorkerView: UIView{
    
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    var allDetailedGpusStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Adjusts detailed GPUs cell view when cell is expanded
    func setupDatailedGPUView(with gpu: Worker) {
        allDetailedGpusStack.removeAllArrangedSubviews()
        if let miners = gpu.minersStats?.hashrates {
            // Row of the stack view
            var arrangedViewQty = 0
            // Miner means t-rex or claymore or any another mining tool
            for miner in miners {
                arrangedViewQty += Int((miner.temps?.count ?? 0) / 6)
                if (miner.temps?.count ?? 0) % 6 != 0 {
                    arrangedViewQty += 1
                }
                // Max qty of detailed gpus view in one row in stack view is 6
                for arrView in 0..<arrangedViewQty {
                    let detailedGpuContainerView = DetailedSingleGPUView(frame: CGRect(x: 0, y: 0, width: 300, height: 52))
                    var spacing: CGFloat = 0
                    var tempArraySlice: ArraySlice<Int> = []
                    var fanArraySlice: ArraySlice<Int> = []
                    var hashArraySlice: ArraySlice<Double> = []
                    
                    if arrangedViewQty == 1 {
                        tempArraySlice = miner.temps![0...]
                        fanArraySlice = miner.fans![0...]
                        hashArraySlice = miner.hashes![0...]
                    } else if arrView > 1, arrView != arrangedViewQty - 1 {
                        tempArraySlice = miner.temps![arrView * 6...(arrView * 6) + 5]
                        fanArraySlice = miner.fans![arrView * 6...(arrView * 6) + 5]
                        hashArraySlice = miner.hashes![arrView * 6...(arrView * 6) + 5]
                    } else if arrView == arrangedViewQty - 1 {
                        tempArraySlice = miner.temps![(arrView * 6)...]
                        fanArraySlice = miner.fans![(arrView * 6)...]
                        hashArraySlice = miner.hashes![(arrView * 6)...]
                    }
                    
                    for (temp, (fan, hash)) in zip(tempArraySlice, zip(fanArraySlice, hashArraySlice)) {
                        if (0..<30).contains(fan) {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: hash, spacing: spacing, fanColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
                            spacing += 50
                        } else if (30..<60).contains(fan) {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: hash, spacing: spacing, fanColor: #colorLiteral(red: 0.0634246245, green: 0.5824196935, blue: 0.9887700677, alpha: 1))
                            spacing += 50
                        } else if (60..<80).contains(fan) {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: hash, spacing: spacing, fanColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
                            spacing += 50
                        } else {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: hash, spacing: spacing, fanColor: #colorLiteral(red: 0.999709247, green: 0.05831817317, blue: 0.01927470519, alpha: 1))
                            spacing += 50
                        }
                    }
                    allDetailedGpusStack.addArrangedSubview(detailedGpuContainerView.view)
                }
            }
        }
    }
    
    func setupConstraints() {
        
        allDetailedGpusStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(allDetailedGpusStack)
        allDetailedGpusStack.distribution = .fillEqually
        allDetailedGpusStack.alignment = .leading
        
        NSLayoutConstraint.activate([
            allDetailedGpusStack.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            allDetailedGpusStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            allDetailedGpusStack.widthAnchor.constraint(equalToConstant: 300),
            allDetailedGpusStack.heightAnchor.constraint(equalToConstant: 52)
        ])
        
    }
}
