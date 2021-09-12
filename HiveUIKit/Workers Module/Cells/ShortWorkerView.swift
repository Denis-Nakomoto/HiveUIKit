//
//  ShortWorkerView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 23.06.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class ShortWorkerView: UIView, StacksAndViewsPreparableProtocol {
    
    var showRigViewDelegate: TransitionToRigProtocol?
    
    var workerId: Int?
    
    var farmId: Int?
    
    var heightsOfStacks: [Int]?
    
    var icons: [String : UIImage]?
    
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    
    let workerNameButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(showRigView), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.titleLabel?.textAlignment = .left
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 15)
        return button
    }()
    
    let upTimeLabel = UILabel(text: "UpTime", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let fanLabelName = UILabel(text: "FAN", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let maxFanSpeedLabel = UILabel(text: "MaxFan", font: .systemFont(ofSize: 10, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    var allConinsHashrateAndIconsStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 5)
    let isNvidiaLabel = UILabel(text: "N", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let isAmdLabel = UILabel(text: "A", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.2784313725, green: 0.1176470588, blue: 0.249258512, alpha: 1))
    var allGpusStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.icons = icons
        setupConstraints(heightsOfStacks: stackHieghts)
        workerNameButton.setTitle(value.name, for: .normal)
        upTimeLabel.text = upTime
        configureCoinsStack(with: value, and: icons, on: allConinsHashrateAndIconsStack)
        configureGpuView(with: value, on: allGpusStack)
        setupNvAmdLabel(worker: value, isAmdLabel: isAmdLabel, isNvidiaLabel: isNvidiaLabel)
        maxFanSpeedLabel.text = "\(value.gpuSummary?.maxFan ?? 0)%"
    }
    
    // Methods of TransitionToRigProtocol, initiates show single rig view
    
    @objc func showRigView() {
        showRigViewDelegate?.showRigView(rigId: self.workerId!, farmId: self.farmId!, icons: self.icons!)
    }
}

extension ShortWorkerView {
    
    // Places all the view elements on the cell. Incoming paramenter is heights of gpus and Icons stacks
    func setupConstraints(heightsOfStacks: [Int]) {
        
        self.heightsOfStacks = heightsOfStacks
        
        workerNameButton.translatesAutoresizingMaskIntoConstraints = false
        upTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        allConinsHashrateAndIconsStack.translatesAutoresizingMaskIntoConstraints = false
        maxFanSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        allGpusStack.translatesAutoresizingMaskIntoConstraints = false
        isNvidiaLabel.translatesAutoresizingMaskIntoConstraints = false
        isAmdLabel.translatesAutoresizingMaskIntoConstraints = false
        fanLabelName.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(workerNameButton)
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
            workerNameButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            workerNameButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
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
            allConinsHashrateAndIconsStack.topAnchor.constraint(equalTo: workerNameButton.bottomAnchor, constant: 16),
            allConinsHashrateAndIconsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            allConinsHashrateAndIconsStack.widthAnchor.constraint(equalToConstant: 200),
            allConinsHashrateAndIconsStack.heightAnchor.constraint(equalToConstant: CGFloat(heightsOfStacks.last ?? 0))
        ])
    }
}
