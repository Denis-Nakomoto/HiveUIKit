//
//  FarmCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.11.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import UIKit

class FarmCell: UICollectionViewCell {
    
    static let reuseId: String = "farmCell"
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    let powerLabel = UILabel(text: "PWR", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.1960784314, green: 0.5882352941, blue: 0.8392156863, alpha: 1))
    let workersQtyLabel = UILabel(text: "WRK", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let effectivencyLabel = UILabel(text: "Effectiv", font: .systemFont(ofSize: 18, weight: .medium), color: .white)
    let gPUQtyLabel = UILabel(text: "GPU", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let ballanceLabel = UILabel(text: "BLNS", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1))
    let farmNameLabel = UILabel(text: "FRMName", font: .systemFont(ofSize: 22, weight: .bold), color: .white)
    let priceLabel = UILabel(text: "PRICE", font: .systemFont(ofSize: 18, weight: .medium), color: .white)
    let hashRateLabel = UILabel(text: "HSRT", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let workersLblName = UILabel(text: "Workers", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let GPUsLblName = UILabel(text: "GPU", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let effectivencyLblName = UILabel(text: "Effectivency", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let ballanceLblName = UILabel(text: "Ballance", font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let priceLblName = UILabel(text: "Daily price",  font: .systemFont(ofSize: 14, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    var allCoinsAndHashStackView = UIStackView(arrangedSubviews: [], axis: .horizontal, spacing: 6)
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
    
    let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
        return iconImageView
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
        let workersStack = UIStackView(arrangedSubviews: [workersQtyLabel, workersLblName],
                                       axis: .vertical,
                                       spacing: 5)
        let gpuStack = UIStackView(arrangedSubviews: [gPUQtyLabel, GPUsLblName],
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
        allCoinsAndHashStackView.translatesAutoresizingMaskIntoConstraints = false
        allCoinsAndHashStackView.alignment = .fill
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
        addSubview(allCoinsAndHashStackView)
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
            powerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
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
            allCoinsAndHashStackView.topAnchor.constraint(equalTo: ballanceStack.bottomAnchor, constant: 14),
            allCoinsAndHashStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            allCoinsAndHashStackView.heightAnchor.constraint(equalToConstant: 26),
            allCoinsAndHashStackView.widthAnchor.constraint(equalToConstant: 200)
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
        hashRateLabel.text = "\(String(format: "%.1f", (value.hashratesByCoin?.first?.hashrate ?? 0.0)/1000))MHs"
        iconImageView.image = icons[(value.hashratesByCoin?.first!.coin)!]
        configureCoinsStack(with: value, and: icons)
    }
    
    func configureCoinsStack(with value: Farm, and icons: [String : UIImage]) {
        let hashrateStack = UIStackView(arrangedSubviews: [], axis: .horizontal, spacing: 3)
        hashrateStack.distribution = .fillEqually
        hashrateStack.alignment = .fill
        for coin in value.hashratesByCoin! {
            for (key, icon) in icons {
                if key == coin.coin {
                    hashRateLabel.text = "\(String(format: "%.1f", (coin.hashrate )/1000))MHs"
                    iconImageView.image = icon
                    hashrateStack.addArrangedSubview(iconImageView)
                    hashrateStack.addArrangedSubview(hashRateLabel)
                    allCoinsAndHashStackView.addArrangedSubview(hashrateStack)
                }
            }
        }
    }
    
    private func setupCardView() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.backgroundColor = .black
    }
    
}
