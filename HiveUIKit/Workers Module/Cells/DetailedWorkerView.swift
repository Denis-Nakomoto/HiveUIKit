//
//  DetailedWorkerView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 16.06.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class DetailedWorkerView: UIView {
    
    let fanNameLabel = UILabel(text: "FAN", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    var fanLabel = UILabel(text: "Fan", font: .systemFont(ofSize: 14, weight: .thin), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    let coreNameLabel = UILabel(text: "CORE", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    var coreLabel = UILabel(text: "Core", font: .systemFont(ofSize: 14, weight: .thin), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    let memNameLabel = UILabel(text: "MEM", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    var memLabel = UILabel(text: "Mem", font: .systemFont(ofSize: 14, weight: .thin), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    let plNameLabel = UILabel(text: "PL", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    var plLabel = UILabel(text: "Pl", font: .systemFont(ofSize: 14, weight: .thin), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    let workerOnlineLabel = UILabel(text: "BOOTED", font: .systemFont(ofSize: 16, weight: .regular), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let workerOnline = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let minerOnlineLabel = UILabel(text: "MINER ONLINE", font: .systemFont(ofSize: 16, weight: .regular), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let minerOnline = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let iPLabel = UILabel(text: "IP", font: .systemFont(ofSize: 16, weight: .regular), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let iP = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let hiveVersionImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let hiveVersion = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let linuxVersionImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let linuxVersion = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    
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
            // Miner means t-rex or claymore or any another mining software
            for miner in miners {
                arrangedViewQty += Int((miner.temps?.count ?? 0) / 6)
                if (miner.temps?.count ?? 0) % 6 != 0 {
                    arrangedViewQty += 1
                }
                // Max qty of detailed gpus view in one row in stack view is 6
                for arrView in 0..<arrangedViewQty {
                    let detailedGpuContainerView = DetailedSingleGPUView(frame: CGRect(x: 0, y: 0, width: 230, height: 52))
                    let detailedGpuBackgroundView = DetailedSingleGPUView(frame: CGRect(x: 0, y: 0, width: 230, height: 52))
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
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: String(format: "%.1f", hash / 1000), spacing: spacing, fanColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
                            spacing += 42
                        } else if (30..<60).contains(fan) {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: String(format: "%.1f", hash / 1000), spacing: spacing, fanColor: #colorLiteral(red: 0.0634246245, green: 0.5824196935, blue: 0.9887700677, alpha: 1))
                            spacing += 42
                        } else if (60..<80).contains(fan) {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: String(format: "%.1f", hash / 1000), spacing: spacing, fanColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                            spacing += 42
                        } else {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: String(format: "%.1f", hash / 1000), spacing: spacing, fanColor: #colorLiteral(red: 0.999709247, green: 0.05831817317, blue: 0.01927470519, alpha: 1))
                            spacing += 42
                        }
                    }
                    allDetailedGpusStack.addArrangedSubview(detailedGpuContainerView.view)
                }
            }
        }
    }
    
    func setupWorkerDetailedView(with value: Worker, workerUBootTime: String?, minerBootTime: String?) {
        setupDatailedGPUView(with: value)
        // TODO AMD overclocking labels
        fanLabel.text = value.overclock?.nvidia?.fanSpeed
        coreLabel.text = value.overclock?.nvidia?.coreClock
        memLabel.text = value.overclock?.nvidia?.memClock
        plLabel.text = value.overclock?.nvidia?.powerLimit
        workerOnline.text = workerUBootTime
        minerOnline.text = minerBootTime
        iP.text = value.ipAddresses?.first
        if value.active == false {
            minerOnlineLabel.text = "WORKER OFFLINE"
        }
    }
    
    func setupConstraints() {
        
        fanNameLabel.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3137254902, blue: 0.1921568627, alpha: 1)
        fanNameLabel.layer.opacity = 0.8
        coreNameLabel.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3137254902, blue: 0.1921568627, alpha: 1)
        coreNameLabel.layer.opacity = 0.8
        memNameLabel.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3137254902, blue: 0.1921568627, alpha: 1)
        memNameLabel.layer.opacity = 0.8
        plNameLabel.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3137254902, blue: 0.1921568627, alpha: 1)
        plNameLabel.layer.opacity = 0.8
        let fanStack = UIStackView(arrangedSubviews: [fanNameLabel, fanLabel], axis: .horizontal, spacing: 4)
        let coreStack = UIStackView(arrangedSubviews: [coreNameLabel, coreLabel], axis: .horizontal, spacing: 4)
        let memStack = UIStackView(arrangedSubviews: [memNameLabel, memLabel], axis: .horizontal, spacing: 4)
        let plStack = UIStackView(arrangedSubviews: [plNameLabel, plLabel], axis: .horizontal, spacing: 4)
        let workerOnlineStack = UIStackView(arrangedSubviews: [workerOnlineLabel, workerOnline], axis: .horizontal, spacing: 4)
        let minerOnlineStack = UIStackView(arrangedSubviews: [minerOnlineLabel, minerOnline], axis: .horizontal, spacing: 4)
        let iPStack = UIStackView(arrangedSubviews: [iPLabel, iP], axis: .horizontal, spacing: 4)
        
        hiveVersionImage.image = UIImage(named: "HiveLogoWhite")
        hiveVersionImage.contentMode = .scaleAspectFit
        linuxVersionImage.image = UIImage(named: "LinuxLogo")
        linuxVersionImage.contentMode = .scaleAspectFit

        let hiveVersionStack = UIStackView(arrangedSubviews: [hiveVersionImage, hiveVersion], axis: .horizontal, spacing: 4)
        let linuxVersionStack = UIStackView(arrangedSubviews: [linuxVersionImage, linuxVersion], axis: .horizontal, spacing: 4)
            
        allDetailedGpusStack.translatesAutoresizingMaskIntoConstraints = false
        fanStack.translatesAutoresizingMaskIntoConstraints = false
        coreStack.translatesAutoresizingMaskIntoConstraints = false
        memStack.translatesAutoresizingMaskIntoConstraints = false
        plStack.translatesAutoresizingMaskIntoConstraints = false
        workerOnlineStack.translatesAutoresizingMaskIntoConstraints = false
        minerOnlineStack.translatesAutoresizingMaskIntoConstraints = false
        iPStack.translatesAutoresizingMaskIntoConstraints = false
        hiveVersionStack.translatesAutoresizingMaskIntoConstraints = false
        linuxVersionStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(allDetailedGpusStack)
        allDetailedGpusStack.distribution = .fillEqually
        allDetailedGpusStack.alignment = .leading
        addSubview(fanStack)
        addSubview(coreStack)
        addSubview(memStack)
        addSubview(plStack)
        addSubview(workerOnlineStack)
        addSubview(minerOnlineStack)
        addSubview(iPStack)
        addSubview(hiveVersionStack)
        addSubview(linuxVersionStack)
        
        NSLayoutConstraint.activate([
            allDetailedGpusStack.topAnchor.constraint(equalTo: topAnchor),
            allDetailedGpusStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            allDetailedGpusStack.widthAnchor.constraint(equalToConstant: 230),
            allDetailedGpusStack.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            fanStack.topAnchor.constraint(equalTo: allDetailedGpusStack.bottomAnchor, constant: 8),
            fanStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            coreStack.topAnchor.constraint(equalTo: fanStack.bottomAnchor, constant: 8),
            coreStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            memStack.topAnchor.constraint(equalTo: coreStack.bottomAnchor, constant: 8),
            memStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            plStack.topAnchor.constraint(equalTo: memStack.bottomAnchor, constant: 8),
            plStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            workerOnlineStack.topAnchor.constraint(equalTo: plStack.bottomAnchor, constant: 8),
            workerOnlineStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            minerOnlineStack.topAnchor.constraint(equalTo: workerOnlineStack.bottomAnchor, constant: 2),
            minerOnlineStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            iPStack.topAnchor.constraint(equalTo: workerOnlineStack.bottomAnchor, constant: 2),
            iPStack.leadingAnchor.constraint(equalTo: minerOnlineStack.trailingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            hiveVersionStack.topAnchor.constraint(equalTo: minerOnlineStack.bottomAnchor, constant: 8),
            hiveVersionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            linuxVersionStack.topAnchor.constraint(equalTo: hiveVersionStack.bottomAnchor, constant: 8),
            linuxVersionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
    }
    
}
