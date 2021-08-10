//
//  ShortWorkerView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 23.06.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class ShortWorkerView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupCardView()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    private func setupCardView() {
        backgroundColor = .black
        addSubview(gradientBackgroundView)
        gradientBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        gradientBackgroundView.layer.cornerRadius = 15
        gradientBackgroundView.clipsToBounds = true

    }
    
    // Configures all the inforamtion in the cell
    func setupWorkerShortView(with value: Worker, and icons: [String : UIImage], stackHieghts: [Int], upTime: String) {
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
        allConinsHashrateAndIconsStack.removeAllArrangedSubviews()
        
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
        allGpusStack.removeAllArrangedSubviews()
        
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
}

extension ShortWorkerView {
    
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
        
        addSubview(workerName)
        addSubview(upTimeLabel)
        addSubview(allConinsHashrateAndIconsStack)
        allConinsHashrateAndIconsStack.distribution = .fillEqually
        allConinsHashrateAndIconsStack.alignment = .leading
        addSubview(allGpusStack)
        allGpusStack.distribution = .fillEqually
        allGpusStack.alignment = .trailing
        
        addSubview(maxFanSpeedLabel)
        addSubview(isNvidiaLabel)
        addSubview(isAmdLabel)
        addSubview(fanLabelName)
        
        NSLayoutConstraint.activate([
            workerName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            workerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            upTimeLabel.trailingAnchor.constraint(equalTo: isAmdLabel.leadingAnchor, constant: 10),
            upTimeLabel.bottomAnchor.constraint(equalTo: maxFanSpeedLabel.bottomAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            fanLabelName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fanLabelName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
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
            allGpusStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            allGpusStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            allGpusStack.widthAnchor.constraint(equalToConstant: 220),
            allGpusStack.heightAnchor.constraint(equalToConstant: CGFloat(heightsOfStacks.first ?? 0))
        ])

        NSLayoutConstraint.activate([
            allConinsHashrateAndIconsStack.topAnchor.constraint(equalTo: workerName.bottomAnchor, constant: 16),
            allConinsHashrateAndIconsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            allConinsHashrateAndIconsStack.widthAnchor.constraint(equalToConstant: 200),
            allConinsHashrateAndIconsStack.heightAnchor.constraint(equalToConstant: CGFloat(heightsOfStacks.last ?? 0))
        ])
    }
}
