//
//  DetailedSingleGPUView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 14.06.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class DetailedSingleGPUView: UIViewController {
    
    init(frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createGpuContainer(temp: Int, fan: Int, hash: String, spacing: CGFloat, fanColor: UIColor) {
        
        let container: UIView = {
           let containerView = UIView()
            containerView.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.2431372549, blue: 0.2901960784, alpha: 1)
            containerView.layer.cornerRadius = 3
            return containerView
        }()

        let gpuTemperature = UILabel(text: "\(temp)°", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
        
        let fanSpeed: UILabel = {
            let label = UILabel(text: "\(fan)%", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
            label.backgroundColor = fanColor
            return label
        }()
        
        let hashrate = UILabel(text: String(hash), font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
        
        self.view.addSubview(container)
        container.addSubview(gpuTemperature)
        container.addSubview(fanSpeed)
        container.addSubview(hashrate)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        gpuTemperature.translatesAutoresizingMaskIntoConstraints = false
        fanSpeed.translatesAutoresizingMaskIntoConstraints = false
        hashrate.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.view.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: spacing),
            container.heightAnchor.constraint(equalToConstant: 52),
            container.widthAnchor.constraint(equalToConstant: 39)
        ])
        
        NSLayoutConstraint.activate([
            gpuTemperature.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            gpuTemperature.topAnchor.constraint(equalTo: container.topAnchor, constant: 2)
        ])

        NSLayoutConstraint.activate([
            fanSpeed.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            fanSpeed.topAnchor.constraint(equalTo: gpuTemperature.bottomAnchor, constant: 2)
        ])

        NSLayoutConstraint.activate([
            hashrate.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            hashrate.topAnchor.constraint(equalTo: fanSpeed.bottomAnchor, constant: 2)
        ])
    }
}
