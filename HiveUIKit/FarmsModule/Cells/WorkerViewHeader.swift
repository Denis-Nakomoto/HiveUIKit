//  WorkerViewHeader.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 19.11.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import UIKit

class WorkerViewHeader: UICollectionReusableView {
    
    static let reuseID = "workerViewHeader"
    
    var rigName = UILabel(text: "Rig", font: .systemFont(ofSize: 14), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var inService = UILabel(text: "3h10m", font: .systemFont(ofSize: 12), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    var amd = UILabel(text: "A", font: .systemFont(ofSize: 12), color: .systemRed)
    var nVidia = UILabel(text: "N", font: .systemFont(ofSize: 12), color: .systemGreen)
    var coinName = UILabel(text: "Coin", font: .boldSystemFont(ofSize: 14), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var hashRate = UILabel(text: "Hash", font: .systemFont(ofSize: 14), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var effectivency = UILabel(text: "Effect", font: .systemFont(ofSize: 10), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    var coinLogo = UIImageView()
    var cardsQty = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        self.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Setup constraints
extension WorkerViewHeader {
    private func setupConstraints(){
        rigName.translatesAutoresizingMaskIntoConstraints = false
        inService.translatesAutoresizingMaskIntoConstraints = false
        amd.translatesAutoresizingMaskIntoConstraints = false
        nVidia.translatesAutoresizingMaskIntoConstraints = false
        coinName.translatesAutoresizingMaskIntoConstraints = false
        hashRate.translatesAutoresizingMaskIntoConstraints = false
        effectivency.translatesAutoresizingMaskIntoConstraints = false
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        cardsQty.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(rigName)
        addSubview(inService)
        addSubview(amd)
        addSubview(nVidia)
        addSubview(coinName)
        addSubview(hashRate)
        addSubview(effectivency)
        addSubview(coinLogo)
        addSubview(cardsQty)
        
        NSLayoutConstraint.activate([
            rigName.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            rigName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            inService.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            inService.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            amd.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            amd.leadingAnchor.constraint(equalTo: inService.trailingAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            nVidia.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            nVidia.leadingAnchor.constraint(equalTo: amd.trailingAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            effectivency.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            effectivency.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            hashRate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            hashRate.trailingAnchor.constraint(equalTo: effectivency.leadingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            coinName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            coinName.trailingAnchor.constraint(equalTo: hashRate.leadingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            coinLogo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            coinLogo.trailingAnchor.constraint(equalTo: coinName.leadingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            cardsQty.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            cardsQty.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
    
//    func setupLabelsData(with value: [Workers]) {
//        rigName.text = value.first?.name
//        inService.text = String(value.first?.stats?.bootTime ?? 0)
//        amd.text = value.first?.hasAMD ?? false ? "A" : ""
//        nVidia.text = value.first?.hasNvidia ?? false ? "N" : ""
//        coinName.text = value.first?.flightSheet?.items?.first?.coin
//        hashRate.text = value.first?.packagesHash
//        effectivency.text = String(value.first?.psuEfficiency ?? 0)
//    }
}
