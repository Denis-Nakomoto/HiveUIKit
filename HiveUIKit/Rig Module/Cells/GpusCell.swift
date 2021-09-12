//
//  GpusCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class GpusCell: UICollectionViewCell {
    
    let topStack = UIStackView(arrangedSubviews: [], axis: .horizontal, spacing: 5)
    let middleStack = UIStackView(arrangedSubviews: [], axis: .horizontal, spacing: 5)
    let bottomStack = UIStackView(arrangedSubviews: [], axis: .horizontal, spacing: 5)
    
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        setupCardView()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topStack.removeAllArrangedSubviews()
        bottomStack.removeAllArrangedSubviews()
        middleStack.removeAllArrangedSubviews()
        removeViews()
    }

    func bind(_ item: FormComponent) {
        guard let item = item as? GpuItem else { return }
        setup(item: item)
    }
}

extension GpusCell {
    
    func setup(item: GpuItem) {
        
        let gpuStat = item.gpuStat
        let gpuInfo = item.gpuInfo
        
        let dictOfProperties = [
            "index": "\(String(describing: gpuInfo.index ?? 0))",
            "bus": "\(String(describing: gpuStat.busID ?? ""))",
            "gpuType": "\(String(describing: gpuInfo.model ?? ""))",
            "mem": "\(String(describing: gpuInfo.details?.mem ?? ""))",
            "vendor": "\(String(describing: gpuInfo.details?.oem ?? ""))",
            "hash": "\(String(describing: gpuStat.hash ?? 0))",
            "temp": "\(String(describing: gpuStat.temp ?? 0))",
            "fan": "\(String(describing: gpuStat.fan ?? 0))",
            "power": "\(String(describing: gpuStat.power ?? 0))",
            "memOem": "\(String(describing: gpuInfo.details?.memOEM ?? ""))",
            "vbios":  "\(String(describing: gpuInfo.details?.vbios ?? ""))",
            "powerLimit":  "\(String(describing: gpuInfo.powerLimit?.min ?? "")) \(String(describing: gpuInfo.powerLimit?.def ?? "")) \(String(describing: gpuInfo.powerLimit?.max ?? ""))"
        ]
        
        let arrayOfTopProperties = ["index", "gpuType", "mem", "vendor"]
        
        let arrayOfMiddleProperties = ["bus", "memOem", "vbios", "powerLimit"]
        
        let arrayOfBottomProperties = ["hash", "temp", "fan", "power"]
        
        for property in arrayOfTopProperties {
            let reuseLabel = UILabel()
            if property == "gpuType" {
                reuseLabel.text = dictOfProperties[property]!
                reuseLabel.textColor = #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1)
                reuseLabel.font = .systemFont(ofSize: 14, weight: .regular)
            } else if property == "index" {
                reuseLabel.text = "GPU \(dictOfProperties[property]!)"
                reuseLabel.textColor = .white
                reuseLabel.font = .systemFont(ofSize: 12, weight: .regular)
            } else {
                reuseLabel.text = dictOfProperties[property]!
                reuseLabel.textColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
                reuseLabel.font = .systemFont(ofSize: 12, weight: .light)
            }
            topStack.addArrangedSubview(reuseLabel)
        }
        
        for property in arrayOfMiddleProperties {
            let reuseLabel = UILabel()
            reuseLabel.text = dictOfProperties[property]!
            reuseLabel.font = .systemFont(ofSize: 12, weight: .light)
            middleStack.addArrangedSubview(reuseLabel)
        }
        for property in arrayOfBottomProperties {
            let reuseLabel = UILabel()
            reuseLabel.text = "\(property.uppercased()) \(dictOfProperties[property]!)"
            reuseLabel.font = .systemFont(ofSize: 16, weight: .regular)
            reuseLabel.textColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
            bottomStack.addArrangedSubview(reuseLabel)
        }
        
    }
    
    func setupConstrains() {
        
        contentView.backgroundColor = .black
        topStack.distribution = .fillProportionally
        bottomStack.distribution = .fillProportionally
        middleStack.distribution = .fillProportionally
        
        addSubview(gradientBackgroundView)
        addSubview(topStack)
        addSubview(bottomStack)
        addSubview(middleStack)
        
        gradientBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        topStack.translatesAutoresizingMaskIntoConstraints = false
        middleStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradientBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            gradientBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            topStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            middleStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 8),
            middleStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.topAnchor.constraint(equalTo: middleStack.bottomAnchor, constant: 8),
            bottomStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
}

