//
//  MinerInfoSubView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 26.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class MinerInfoSubView: UIView {
    
    let minerSoft = UILabel(text: "MinerSoft", font: .systemFont(ofSize: 14, weight: .regular), color: .white)
    let minerSoftVersion = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let ration = UILabel(text: "Efectivency ", font: .systemFont(ofSize: 14, weight: .regular), color: .white)
    let flightSheet = UILabel(text: "FS", font: .systemFont(ofSize: 14, weight: .regular), color: .white)
    let wallet = UILabel(text: "Wallet", font: .systemFont(ofSize: 14, weight: .regular), color: .white)
    let pool = UILabel(text: "Pool", font: .systemFont(ofSize: 14, weight: .regular), color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(worker: Worker) {
        minerSoft.text = worker.minersSummary?.hashrates?.first?.miner
        
        if let ver = worker.minersSummary?.hashrates?.first?.ver {
        minerSoftVersion.text = " v.\(ver)"
        }
        
        if let ratio = worker.minersSummary?.hashrates?.first?.shares?.ratio {
        ration.text = "\(ratio)%"
        }
        
        flightSheet.text = worker.flightSheet?.name
        pool.text = worker.flightSheet?.items?.first?.pool
    }
    
    private func setupView() {
        
        backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2078431373, blue: 0.2352941176, alpha: 1)
        layer.cornerRadius = 8
        
        let topStack = UIStackView(arrangedSubviews: [minerSoft, minerSoftVersion, ration], axis: .horizontal, spacing: 8)
        let bottomStack = UIStackView(arrangedSubviews: [flightSheet, pool], axis: .horizontal, spacing: 8)
        
        addSubview(topStack)
        addSubview(bottomStack)
        
        topStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            topStack.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            bottomStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 1)
        ])
    }
}
