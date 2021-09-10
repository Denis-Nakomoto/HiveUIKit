//
//  CoinsIconContainerView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 24.05.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class ContainerView: UIViewController {
    
    var iconImage = UIImageView()
    
    var hashrateLabel = UILabel(text: "HSRT", font: .systemFont(ofSize: 14, weight: .semibold), color: .white)
    
    var coinLabel = UILabel(text: "Coin", font: .systemFont(ofSize: 14, weight: .semibold), color: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(iconImage)
        view.addSubview(coinLabel)
        view.addSubview(hashrateLabel)
        setupConstraints()
    }
    
    init(frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        hashrateLabel.translatesAutoresizingMaskIntoConstraints = false
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            iconImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 26),
            iconImage.widthAnchor.constraint(equalToConstant: 26),
        ])
        
        NSLayoutConstraint.activate([
            coinLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            hashrateLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor),
            hashrateLabel.leadingAnchor.constraint(equalTo: coinLabel.trailingAnchor, constant: 4),
        ])

    }
    
}
