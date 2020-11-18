//
//  FarmCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.11.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import UIKit

class FarmCell: UICollectionViewCell {
    
    static var reuseId: String = "farmCell"
    var powerLabel = UILabel(text: "PWR", color: #colorLiteral(red: 0.5490196078, green: 0.7411764706, blue: 0.9568627451, alpha: 1))
    var workersQtyLabel = UILabel(text: "WRK")
    var effectivencyLabel = UILabel(text: "EFT")
    var gPUQtyLabel = UILabel(text: "GPU")
    var ballanceLabel = UILabel(text: "BLNS")
    var farmNameLabel = UILabel(text: "FRName")
    var priceLabel = UILabel(text: "PRCE")
    var hashRateLabel = UILabel(text: "HRT")
    let farmIndictorView = UIView()
    //    let powerLblName = UILabel(text: "Power consuming", color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let workersLblName = UILabel(text: "Workers QTY", font: .systemFont(ofSize: 12), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let GPUsLblName = UILabel(text: "GPUs QTY", font: .systemFont(ofSize: 12), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let effectivencyLblName = UILabel(text: "Efficiency", font: .systemFont(ofSize: 12), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let ballanceLblName = UILabel(text: "Ballance",  font: .systemFont(ofSize: 12), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let priceLblName = UILabel(text: "Price",  font: .systemFont(ofSize: 12), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let hashrateLblName = UILabel(text: "Hashrate",  font: .systemFont(ofSize: 12), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    
    
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        setupConstraints()
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
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
        let ballanceStack = UIStackView(arrangedSubviews: [ballanceLabel, ballanceLblName],
                                        axis: .vertical,
                                        spacing: 5)
        let priceStack = UIStackView(arrangedSubviews: [priceLabel, priceLblName],
                                     axis: .vertical,
                                     spacing: 5)
        let hashrateStack = UIStackView(arrangedSubviews: [hashRateLabel, hashrateLblName],
                                        axis: .vertical,
                                        spacing: 5)
        workersStack.translatesAutoresizingMaskIntoConstraints = false
        gpuStack.translatesAutoresizingMaskIntoConstraints = false
        effectivencyStack.translatesAutoresizingMaskIntoConstraints = false
        ballanceStack.translatesAutoresizingMaskIntoConstraints = false
        priceStack.translatesAutoresizingMaskIntoConstraints = false
        hashrateStack.translatesAutoresizingMaskIntoConstraints = false
        farmIndictorView.translatesAutoresizingMaskIntoConstraints = false
        powerLabel.translatesAutoresizingMaskIntoConstraints = false
        farmNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        farmIndictorView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        addSubview(workersStack)
        addSubview(gpuStack)
        addSubview(effectivencyStack)
        addSubview(ballanceStack)
        addSubview(priceStack)
        addSubview(hashrateStack)
        addSubview(farmIndictorView)
        addSubview(farmNameLabel)
        addSubview(powerLabel)
        
        
        NSLayoutConstraint.activate([
            farmIndictorView.topAnchor.constraint(equalTo: self.topAnchor),
            farmIndictorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            farmIndictorView.heightAnchor.constraint(equalToConstant: 6),
            farmIndictorView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            farmNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            farmNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            workersStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 36),
            workersStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            gpuStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 36),
            gpuStack.leadingAnchor.constraint(equalTo: workersStack.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            effectivencyStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 36),
            effectivencyStack.leadingAnchor.constraint(equalTo: gpuStack.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            powerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 36),
            powerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            ballanceStack.topAnchor.constraint(equalTo: workersStack.bottomAnchor, constant: 10),
            ballanceStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            priceStack.topAnchor.constraint(equalTo: workersStack.bottomAnchor, constant: 10),
            priceStack.leadingAnchor.constraint(equalTo: ballanceStack.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            hashrateStack.topAnchor.constraint(equalTo: workersStack.bottomAnchor, constant: 10),
            hashrateStack.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 16)
        ])
        
    }
    
    func setupLabelsData(with value: Datum) {
        powerLabel.text = "\(value.stats!.powerDraw)W"
        workersQtyLabel.text = String(value.workersCount)
        effectivencyLabel.text = "\(value.stats!.asr)%"
        gPUQtyLabel.text = String(value.stats!.gpusOnline)
        ballanceLabel.text = "\(value.money!.balance)$"
        farmNameLabel.text = String(value.name)
        priceLabel.text = "\(value.money!.dailyPrice)$"
        hashRateLabel.text = "\(String(format: "%.1f", (value.hashratesByCoin?.first?.hashrate ?? 0.0)/1000))MHs"
    }
}

// MARK: - SwiftUI
import SwiftUI

struct FarmCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = FarmViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<FarmCellProvider.ContainerView>) -> FarmViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: FarmCellProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<FarmCellProvider.ContainerView>) {
            
        }
    }
}
