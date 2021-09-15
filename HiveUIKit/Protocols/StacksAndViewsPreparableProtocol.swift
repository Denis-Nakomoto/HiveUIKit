//
//  GpuStracksPreparable.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 07.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

protocol StacksAndViewsPreparableProtocol {
    
    // Prepares stack view contains coin logo and hashrate value
    func configureCoinsStack(with value: Worker, and icons: [String : UIImage], on: UIStackView)
    
    // Prepares stack view contains picto of all the gpu available into the worker
    func configureGpuView(with worker: Worker, on: UIStackView)
    
    // Adjusts detailed GPUs cell view when cell is expanded
    func setupDatailedGPUView(with gpu: Worker, on stack: UIStackView)
    
    // Choses what type of gpu is available
    func setupNvAmdLabel(worker: Worker, isAmdLabel: UILabel, isNvidiaLabel: UILabel)
    
    // Setup of gpus drivers version label
    func setupDriversStack(with worker: Worker, on stack: UIStackView)
    
    // Setup card type view on the bottom of detailed worker view
    func typeOfGpuStackSetup(with worker: Worker, on stack: UIStackView)
    
    // Set labels is worker is offline
    func workerOfflineSetup(with worker: Worker, on isOfflineLabel: UILabel, and allGpusStack: UIStackView)
    
    // Set data for info field in detailed subview
    func setDataForInfoField(worker: Worker, on stack: UIStackView)
    
}

extension StacksAndViewsPreparableProtocol {
    
    // Prepares stack view contains coin logo and hashrate value
    func configureCoinsStack(with value: Worker, and icons: [String : UIImage], on stack: UIStackView) {
        
        stack.removeAllArrangedSubviews()
        
        guard let coins = value.minersSummary?.hashrates else { return }
        for coin in coins {
            for (key, icon) in icons {
                if key == coin.coin {
                    let container = ContainerView(frame: CGRect(x: 0, y: 0, width: 200, height: 27))
                    container.iconImage.image = icon
                    container.coinLabel.text = value.minersSummary?.hashrates?.first?.coin
                    container.hashrateLabel.text = String(describing: value.minersSummary?.hashrates?.first?.hash?.toSiUnitsAsETH() ?? "")
                    stack.addArrangedSubview(container.view)
                }
            }
        }
    }
    
    // Prepares stack view contains picto of all the gpu available into the worker
    func configureGpuView(with worker: Worker, on stack: UIStackView) {
        
        stack.removeAllArrangedSubviews()
        
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
            stack.addArrangedSubview(gpuContainerView.view)
        }
    }
    
    // Adjusts detailed GPUs cell view when cell is expanded
    func setupDatailedGPUView(with worker: Worker, on stack: UIStackView) {
        
        stack.removeAllArrangedSubviews()
        if let miners = worker.minersStats?.hashrates {
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
                    var spacing: CGFloat = 0
                    var tempArraySlice: ArraySlice<Int> = []
                    var fanArraySlice: ArraySlice<Int> = []
                    var hashArraySlice: ArraySlice<Double> = []
                    
                    if arrangedViewQty == 1 {
                        tempArraySlice = miner.temps![0...]
                        fanArraySlice = miner.fans![0...]
                        hashArraySlice = miner.hashes![0...]
                    } else if arrView >= 0, arrView != arrangedViewQty - 1 {
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
                        } else if (30...60).contains(fan) {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: String(format: "%.1f", hash / 1000), spacing: spacing, fanColor: #colorLiteral(red: 0.1725490196, green: 0.5764705882, blue: 0.8509803922, alpha: 1))
                            spacing += 42
                        } else if (61..<80).contains(fan) {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: String(format: "%.1f", hash / 1000), spacing: spacing, fanColor: #colorLiteral(red: 0.9960784314, green: 0.8, blue: 0.431372549, alpha: 1))
                            spacing += 42
                        } else {
                            detailedGpuContainerView.createGpuContainer(temp: temp, fan: fan, hash: String(format: "%.1f", hash / 1000), spacing: spacing, fanColor: #colorLiteral(red: 0.9882352941, green: 0.3215686275, blue: 0.3176470588, alpha: 1))
                            spacing += 42
                        }
                    }
                    stack.addArrangedSubview(detailedGpuContainerView.view)
                }
            }
        }
    }
    
    // Choses what type of gpu is available
    func setupNvAmdLabel(worker: Worker, isAmdLabel: UILabel, isNvidiaLabel: UILabel) {
        if worker.hasAMD == false && worker.hasNvidia == true {
            isAmdLabel.isHidden = true
        } else if worker.hasAMD == true && worker.hasNvidia == false {
            isNvidiaLabel.isHidden = true
        } else if worker.hasAMD == true && worker.hasNvidia == true {
            isAmdLabel.isHidden = false
            isNvidiaLabel.isHidden = false
        }
    }
    
    // Setup of gpus drivers version label
    func setupDriversStack(with worker: Worker, on stack: UIStackView) {
        stack.removeAllArrangedSubviews()
        let nVidiaDriverLabel = UILabel(text: "N", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
        let amdDriverLabel = UILabel(text: "A", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
        let nvidiaLabel = UILabel(text: "N", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
        let amdLabel = UILabel(text: "A", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.2784313725, green: 0.1176470588, blue: 0.249258512, alpha: 1))
        let nVidiaStack = UIStackView(arrangedSubviews: [nvidiaLabel, nVidiaDriverLabel], axis: .horizontal, spacing: 4)
        let amdStack = UIStackView(arrangedSubviews: [amdLabel, amdDriverLabel], axis: .horizontal, spacing: 4)
        
        nVidiaDriverLabel.text = worker.versions?.nvidiaDriver
        amdDriverLabel.text = worker.versions?.amdDriver
        
        if worker.hasAMD == false && worker.hasNvidia == true {
            amdStack.isHidden = true
            stack.addArrangedSubview(nVidiaStack)
        } else if worker.hasAMD == true && worker.hasNvidia == false {
            nVidiaStack.isHidden = true
            stack.addArrangedSubview(amdStack)
        } else if worker.hasAMD == true && worker.hasNvidia == true {
            nVidiaStack.isHidden = false
            amdStack.isHidden = false
            stack.addArrangedSubview(nVidiaStack)
            stack.addArrangedSubview(amdStack)
        }
    }
    
    // Setup card type view on the bottom of detailed worker view
    func typeOfGpuStackSetup(with worker: Worker, on stack: UIStackView) {
        
        stack.removeAllArrangedSubviews()

        var arrayOfNvidiaGpus: [String] = []
        var arrayOfAmdGpus: [String] = []
        var summaryArray: [CardType] = []
        var arrangedViewQty = 0

        for gpu in worker.gpuInfo! {
            if gpu.brand == "nvidia" {
                arrayOfNvidiaGpus.append(gpu.shortName ?? "")
            } else {
                arrayOfAmdGpus.append(gpu.shortName ?? "")
            }
        }
        
        for (key, value) in arrayOfNvidiaGpus.frequency {
            let item = CardType(card: key, brand: "nvidia", qty: String(describing: value))
            summaryArray.append(item)
        }
        
        for (key, value) in arrayOfAmdGpus.frequency {
            let item = CardType(card: key, brand: "amd", qty: String(describing: value))
            summaryArray.append(item)
        }
        
        arrangedViewQty += Int(summaryArray.count / 3)
        if summaryArray.count % 3 != 0 {
            arrangedViewQty += 1
        }
        
        for arrView in 0..<arrangedViewQty {
            
            let cardTypeContainerView = CardTypeContainerView(frame: CGRect(x: 0, y: 0, width: 300, height: 18))
            var spacing: CGFloat = 0
            var arraySlice: ArraySlice<CardType> = []
            
            if arrangedViewQty == 1 {
                arraySlice = summaryArray[0...]
            } else if arrView >= 0, arrView != arrangedViewQty - 1 {
                arraySlice = summaryArray[arrView * 3...(arrView * 3) + 2]
            } else if arrView == arrangedViewQty - 1 {
                arraySlice = summaryArray[(arrView * 3)...]
            }
            
            for card in arraySlice {
                if card.brand == "nvidia" {
                    cardTypeContainerView.setupCardTypeContainerView(cards: card.card,
                                                                     qty: card.qty,
                                                                     brand: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1),
                                                                     spacing: spacing)
                } else {
                    cardTypeContainerView.setupCardTypeContainerView(cards: card.card,
                                                                     qty: card.qty,
                                                                     brand: #colorLiteral(red: 0.2784313725, green: 0.1176470588, blue: 0.249258512, alpha: 1),
                                                                     spacing: spacing)
                }
                spacing += 85
            }
            stack.addArrangedSubview(cardTypeContainerView)
        }
    }
    
    // Set labels is worker is offline
    func workerOfflineSetup(with worker: Worker, on isOfflineLabel: UILabel, and allGpusStack: UIStackView) {
        if worker.stats?.online == true {
            isOfflineLabel.isHidden = true
            allGpusStack.isHidden = false
        } else {
            isOfflineLabel.isHidden = false
            allGpusStack.isHidden = true
        }
    }
    
    // Set data for info field in detailed subview
    func setDataForInfoField(worker: Worker, on stack: UIStackView) {

        stack.removeAllArrangedSubviews()
        
        worker.minersSummary?.hashrates?.forEach ({
            let minerInfoField = MinerInfoSubView()
            
            minerInfoField.minerSoft.text = $0.miner
            
            if let ver = $0.ver {
                minerInfoField.minerSoftVersion.text = " v.\(ver)"
            }
            
            if let ratio = $0.shares?.ratio {
                minerInfoField.ration.text = "\(ratio)%"
            }
            
            minerInfoField.flightSheet.text = worker.flightSheet?.name
            var pools = ""
            worker.flightSheet?.items?.forEach({
                pools += $0.pool!
            })
            minerInfoField.pool.text = pools
            stack.addArrangedSubview(minerInfoField)
        })
    }
    
}
