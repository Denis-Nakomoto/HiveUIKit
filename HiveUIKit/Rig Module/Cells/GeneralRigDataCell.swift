//
//  RigCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 02.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class GeneralRigDataCell: UICollectionViewCell {
    
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    
    let workerName = UILabel(text: "WorkerName", font: .systemFont(ofSize: 14, weight: .regular), color: .white)
    let upTimeLabel = UILabel(text: "UpTime", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let fanLabelName = UILabel(text: "FAN", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let maxFanSpeedLabel = UILabel(text: "MaxFan", font: .systemFont(ofSize: 10, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let powerConsumingIcon = UIImageView(image: UIImage(named: "bolt.fill"))
    var allConinsHashrateAndIconsStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 5)
    let powerConsuming = UILabel(text: "Consuming", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0.1960784314, green: 0.5882352941, blue: 0.8392156863, alpha: 1))
    let isNvidiaLabel = UILabel(text: "N", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let isAmdLabel = UILabel(text: "A", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    var allGpusStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 8)
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
    }

    func bind(_ item: FormComponent, heightsOfStacks: [Int]) {
        guard let item = item as? RigItem else { return }
        setupConstraints(heightsOfStacks: heightsOfStacks)
        setup(item: item)
    }
    
}

extension GeneralRigDataCell {
    
    func setup(item: RigItem) {
        
    }
    
    func setupConstraints(heightsOfStacks: [Int]) {
        contentView.backgroundColor = .red
        workerName.translatesAutoresizingMaskIntoConstraints = false
        upTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        allConinsHashrateAndIconsStack.translatesAutoresizingMaskIntoConstraints = false
        maxFanSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        allGpusStack.translatesAutoresizingMaskIntoConstraints = false
        isNvidiaLabel.translatesAutoresizingMaskIntoConstraints = false
        isAmdLabel.translatesAutoresizingMaskIntoConstraints = false
        fanLabelName.translatesAutoresizingMaskIntoConstraints = false
        
        let powerStack = UIStackView(arrangedSubviews: [powerConsumingIcon, powerConsuming], axis: .horizontal, spacing: 3)
        
        addSubview(workerName)
        addSubview(upTimeLabel)
        addSubview(allConinsHashrateAndIconsStack)
        allConinsHashrateAndIconsStack.distribution = .fillEqually
        allConinsHashrateAndIconsStack.alignment = .leading
        addSubview(allGpusStack)
        allGpusStack.distribution = .fillEqually
        allGpusStack.alignment = .trailing
        addSubview(powerStack)
        powerStack.distribution = .fill
        
        addSubview(maxFanSpeedLabel)
        addSubview(isNvidiaLabel)
        addSubview(isAmdLabel)
        addSubview(fanLabelName)
        
        NSLayoutConstraint.activate([
            workerName.topAnchor.constraint(equalTo: topAnchor, constant: 8),
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
