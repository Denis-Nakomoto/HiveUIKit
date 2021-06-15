//
//  WorkerCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 12.06.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class WorkerCell: UITableViewCell {
    
    static var reuseId: String = "workerCell"
    var isExpanded = false
    var cellHeight = 80
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    let workerName = UILabel(text: "WRKRName", font: .systemFont(ofSize: 14, weight: .regular), color: .white)
    let upTimeLabel = UILabel(text: "UpTime", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let fanLabelName = UILabel(text: "FAN", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let maxFanSpeedLabel = UILabel(text: "MaxFan", font: .systemFont(ofSize: 10, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let powerConsumingLabel = UILabel(text: "PWRConsuming", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    var allConinsHashrateAndIconsStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 5)
    let powerConsuming = UILabel(text: "Consuming", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let isNvidiaLabel = UILabel(text: "N", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let isAmdLabel = UILabel(text: "A", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    var allGpusStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 8)
    var allDetailedGpusStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 8)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCardView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    private func setupCardView() {
        backgroundColor = .black
        contentView.addSubview(gradientBackgroundView)
        gradientBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        gradientBackgroundView.layer.cornerRadius = 15
        gradientBackgroundView.clipsToBounds = true
        gradientBackgroundView.backgroundColor = .black
    }
    
    // Configures all the inforamtion in the cell
    func setupWorkerCell(with value: Worker, and icons: [String : UIImage], stackHieghts: [Int], upTime: String) {
        backgroundColor = UIColor.black
        setupConstraints(heightsOfStacks: stackHieghts)
        workerName.text = value.name
        upTimeLabel.text = upTime
        configureCoinsStack(with: value, and: icons)
        configureGpuView(with: value)
        setupNvAmdLabel(worker: value)
        maxFanSpeedLabel.text = "\(value.gpuSummary?.maxFan ?? 0)%"
    }
    
    // Prepares stack view contains coin logo and hashrate value
    func configureCoinsStack(with value: Worker, and icons: [String : UIImage]) {
        guard let coins = value.minersSummary?.hashrates else { return }
        for coin in coins {
            for (key, icon) in icons {
                if key == coin.coin {
                    let container = ContainerView(frame: CGRect(x: 0, y: 0, width: 200, height: 27))
                    container.iconImage.image = icon
                    container.hashRateLabel.text = "\(String(format: "%.1f", (value.minersSummary?.hashrates?.first?.hash ?? 0)/1000))MHs"
                    allConinsHashrateAndIconsStack.addArrangedSubview(container.view)
                }
            }
        }
    }
    
    // Prepares stack view contains picto of all the gpu available into the worker
    func configureGpuView(with worker: Worker) {
        
        var arrangedViewQty = Int((worker.gpuStats?.count ?? 0) / 10)
        
        if worker.gpuStats?.count ?? 0 % 10 != 0 {
            arrangedViewQty += 1
        }
        
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
            allGpusStack.addArrangedSubview(gpuContainerView.view)
        }
    }
    
    // Choses what type of gpu are available
    func setupNvAmdLabel(worker: Worker) {
        if worker.hasAMD == false && worker.hasNvidia == true {
            isAmdLabel.isHidden = true
        } else if worker.hasAMD == true && worker.hasNvidia == false {
            isNvidiaLabel.isHidden = true
        } else if worker.hasAMD == true && worker.hasNvidia == true {
            isNvidiaLabel.isHidden = false
            isNvidiaLabel.isHidden = false
        }
    }
    
    // Adjusts detailed GPUs cell view when cell is expanded
    func setupDatailedGPUView(with gpu: Worker) {
        
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
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: hash, spacing: spacing, fanColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1))
                            spacing += 50
                        }
                    }
                    allDetailedGpusStack.addArrangedSubview(detailedGpuContainerView.view)
                }
            }
        }
    }
    
}

extension WorkerCell {
    
    // Places all the view elements on the cell. Incoming paramenter is heights of gpus and Icons stacks
    func setupConstraints(heightsOfStacks: [Int]) {
        
        workerName.translatesAutoresizingMaskIntoConstraints = false
        upTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        allConinsHashrateAndIconsStack.translatesAutoresizingMaskIntoConstraints = false
        maxFanSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        allGpusStack.translatesAutoresizingMaskIntoConstraints = false
        isNvidiaLabel.translatesAutoresizingMaskIntoConstraints = false
        isAmdLabel.translatesAutoresizingMaskIntoConstraints = false
        fanLabelName.translatesAutoresizingMaskIntoConstraints = false
        allDetailedGpusStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(workerName)
        contentView.addSubview(upTimeLabel)
        contentView.addSubview(allConinsHashrateAndIconsStack)
        allConinsHashrateAndIconsStack.distribution = .fillEqually
        allConinsHashrateAndIconsStack.alignment = .leading
        contentView.addSubview(allGpusStack)
        allGpusStack.distribution = .fillEqually
        allGpusStack.alignment = .trailing
        contentView.addSubview(allDetailedGpusStack)
        allDetailedGpusStack.distribution = .fillEqually
        allDetailedGpusStack.alignment = .leading
        contentView.addSubview(maxFanSpeedLabel)
        contentView.addSubview(isNvidiaLabel)
        contentView.addSubview(isAmdLabel)
        contentView.addSubview(fanLabelName)
        
        NSLayoutConstraint.activate([
            gradientBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            gradientBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            gradientBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            gradientBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            gradientBackgroundView.heightAnchor.constraint(equalToConstant: CGFloat(cellHeight))
        ])
        
        NSLayoutConstraint.activate([
            workerName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            workerName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            upTimeLabel.trailingAnchor.constraint(equalTo: isAmdLabel.leadingAnchor, constant: 10),
            upTimeLabel.bottomAnchor.constraint(equalTo: maxFanSpeedLabel.bottomAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            fanLabelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            fanLabelName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            maxFanSpeedLabel.centerXAnchor.constraint(equalTo: fanLabelName.centerXAnchor),
            maxFanSpeedLabel.topAnchor.constraint(equalTo: fanLabelName.bottomAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            isNvidiaLabel.trailingAnchor.constraint(equalTo: maxFanSpeedLabel.leadingAnchor, constant: -20),
            isNvidiaLabel.bottomAnchor.constraint(equalTo: maxFanSpeedLabel.bottomAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            isAmdLabel.trailingAnchor.constraint(equalTo: isNvidiaLabel.leadingAnchor, constant: -5),
            isAmdLabel.bottomAnchor.constraint(equalTo: maxFanSpeedLabel.bottomAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            allGpusStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            allGpusStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            allGpusStack.widthAnchor.constraint(equalToConstant: 220),
            allGpusStack.heightAnchor.constraint(equalToConstant: CGFloat(heightsOfStacks.first ?? 0))
        ])
        
        NSLayoutConstraint.activate([
            allDetailedGpusStack.topAnchor.constraint(equalTo: maxFanSpeedLabel.bottomAnchor, constant: 25),
            allDetailedGpusStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            allDetailedGpusStack.widthAnchor.constraint(equalToConstant: 300),
            allDetailedGpusStack.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            allConinsHashrateAndIconsStack.topAnchor.constraint(equalTo: workerName.bottomAnchor, constant: 16),
            allConinsHashrateAndIconsStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            allConinsHashrateAndIconsStack.widthAnchor.constraint(equalToConstant: 200),
            allConinsHashrateAndIconsStack.heightAnchor.constraint(equalToConstant: CGFloat(heightsOfStacks.last ?? 0))
        ])
    }
}

