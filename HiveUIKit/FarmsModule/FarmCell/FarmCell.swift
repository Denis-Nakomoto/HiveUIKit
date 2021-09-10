//
//  FarmCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.11.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import UIKit

class FarmCell: UICollectionViewCell {
    
    var stackHeight = 40
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    let powerLabel = UILabel(text: "PWR", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.1960784314, green: 0.5882352941, blue: 0.8392156863, alpha: 1))
    let workersQtyLabel = UILabel(text: "WRK", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let workersOfflineQtyLabel = UILabel(text: "0", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    let effectivencyLabel = UILabel(text: "Effectiv", font: .systemFont(ofSize: 18, weight: .medium), color: .white)
    let gPUQtyLabel = UILabel(text: "GPU", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let gPUOfflineQtyLabel = UILabel(text: "0", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    let ballanceLabel = UILabel(text: "BLNS", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let farmNameLabel = UILabel(text: "FRMName", font: .systemFont(ofSize: 22, weight: .bold), color: .white)
    let priceLabel = UILabel(text: "PRICE", font: .systemFont(ofSize: 18, weight: .medium), color: .white)
    let hashRateLabel = UILabel(text: "HSRT", font: .systemFont(ofSize: 18, weight: .medium), color: .white)
    let workersLblName = UILabel(text: "Workers", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let GPUsLblName = UILabel(text: "GPU", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let effectivencyLblName = UILabel(text: "Effectivency", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let ballanceLblName = UILabel(text: "Ballance", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let priceLblName = UILabel(text: "Daily price",  font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    var allConinsHashrateAndIconsStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 5)
    let powerLblName = UILabel(text: "Consumation", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    
    
    let separator: UIView = {
        let separator = UIView(frame: .zero)
        separator.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
        return separator
    }()
    
    let farmIndictorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1)
        return view
    }()
    
    var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        image.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        setupCardView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}

//MARK: - Setup constraints
extension FarmCell {
    private func setupConstraints() {
        
        let workersOnOffStack = UIStackView(arrangedSubviews: [workersQtyLabel, workersOfflineQtyLabel], axis: .horizontal, spacing: 3)
        workersOnOffStack.distribution = .fillEqually
        
        let workersStack = UIStackView(arrangedSubviews: [workersOnOffStack, workersLblName],
                                       axis: .vertical,
                                       spacing: 5)
        
        let gpusOnOffStack = UIStackView(arrangedSubviews: [gPUQtyLabel, gPUOfflineQtyLabel], axis: .horizontal, spacing: 3)
        gpusOnOffStack.distribution = .fillEqually
        
        let gpuStack = UIStackView(arrangedSubviews: [gpusOnOffStack, GPUsLblName],
                                   axis: .vertical,
                                   spacing: 5)
        let effectivencyStack = UIStackView(arrangedSubviews: [effectivencyLabel, effectivencyLblName],
                                            axis: .vertical,
                                            spacing: 5)
        let powerStack = UIStackView(arrangedSubviews: [powerLabel, powerLblName],
                                     axis: .vertical,
                                     spacing: 5)
        let ballanceStack = UIStackView(arrangedSubviews: [ballanceLabel, ballanceLblName],
                                        axis: .vertical,
                                        spacing: 5)
        let priceStack = UIStackView(arrangedSubviews: [priceLabel, priceLblName],
                                     axis: .vertical,
                                     spacing: 5)
        
        
        gradientBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        workersStack.translatesAutoresizingMaskIntoConstraints = false
        gpuStack.translatesAutoresizingMaskIntoConstraints = false
        effectivencyStack.translatesAutoresizingMaskIntoConstraints = false
        ballanceStack.translatesAutoresizingMaskIntoConstraints = false
        priceStack.translatesAutoresizingMaskIntoConstraints = false
        farmIndictorView.translatesAutoresizingMaskIntoConstraints = false
        powerStack.translatesAutoresizingMaskIntoConstraints = false
        farmNameLabel.translatesAutoresizingMaskIntoConstraints = false
        allConinsHashrateAndIconsStack.translatesAutoresizingMaskIntoConstraints = false
        allConinsHashrateAndIconsStack.distribution = .fill
        allConinsHashrateAndIconsStack.alignment = .leading
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(gradientBackgroundView)
        addSubview(workersStack)
        addSubview(gpuStack)
        addSubview(effectivencyStack)
        addSubview(ballanceStack)
        addSubview(priceStack)
        addSubview(farmIndictorView)
        addSubview(farmNameLabel)
        addSubview(powerStack)
        addSubview(allConinsHashrateAndIconsStack)
        allConinsHashrateAndIconsStack.distribution = .fill
        allConinsHashrateAndIconsStack.alignment = .fill
        addSubview(separator)
        
        NSLayoutConstraint.activate([
            gradientBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            gradientBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gradientBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            farmIndictorView.topAnchor.constraint(equalTo: self.topAnchor),
            farmIndictorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            farmIndictorView.heightAnchor.constraint(equalToConstant: 6),
            farmIndictorView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            farmNameLabel.topAnchor.constraint(equalTo: farmIndictorView.bottomAnchor, constant: 3),
            farmNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: farmNameLabel.bottomAnchor, constant: 4),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            workersStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            workersStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            gpuStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            gpuStack.leadingAnchor.constraint(equalTo: workersStack.trailingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            effectivencyStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            effectivencyStack.leadingAnchor.constraint(equalTo: gpuStack.trailingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            powerStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            powerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            powerStack.leadingAnchor.constraint(equalTo: effectivencyStack.trailingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            ballanceStack.topAnchor.constraint(equalTo: workersStack.bottomAnchor, constant: 10),
            ballanceStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            priceStack.topAnchor.constraint(equalTo: workersStack.bottomAnchor, constant: 10),
            priceStack.leadingAnchor.constraint(equalTo: ballanceStack.trailingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            allConinsHashrateAndIconsStack.topAnchor.constraint(equalTo: ballanceStack.bottomAnchor, constant: 16),
            allConinsHashrateAndIconsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            allConinsHashrateAndIconsStack.widthAnchor.constraint(equalToConstant: 200),
            allConinsHashrateAndIconsStack.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight))
        ])
        
    }
    
    func setupLabelsData(with value: Farm, and icons: [String : UIImage]) {
        powerLabel.text = "\(value.stats!.powerDraw)W"
        workersQtyLabel.text = String(value.workersCount)
        effectivencyLabel.text = "\(value.stats!.asr)%"
        gPUQtyLabel.text = String(value.stats!.gpusOnline)
        ballanceLabel.text = "\(value.money!.balance)$"
        farmNameLabel.text = String(value.name)
        priceLabel.text = "\(value.money!.dailyPrice)$"
        configureCoinsStack(with: value, and: icons)
        setupWorkersOnlineLabel(value: value)
    }
    
    func setupWorkersOnlineLabel(value: Farm) {
        if value.stats?.workersOffline == 0 {
            workersOfflineQtyLabel.isHidden = true
        } else {
            workersOfflineQtyLabel.text = String(value.stats!.workersOffline)
        }
        
        if value.stats?.gpusOffline == 0 {
            gPUOfflineQtyLabel.isHidden = true
        } else {
            gPUOfflineQtyLabel.text = String(value.stats!.workersOffline)
        }
    }
    
    func configureCoinsStack(with value: Farm, and icons: [String : UIImage]) {
        if let value = value.hashratesByCoin {
            for coin in value {
                for (key, icon) in icons {
                    if key == coin.coin {
                        stackHeight += 40
                        let container = ContainerView(frame: CGRect(x: 0, y: 0, width: 200, height: 27))
                        container.iconImage.image = icon
                        container.coinLabel.text = coin.coin
                        container.hashrateLabel.text = "\(String(format: "%.1f", (coin.hashrate)/1000))MHs"
                        allConinsHashrateAndIconsStack.addArrangedSubview(container.view)
                    }
                }
            }
        }
    }
    
}

