//
//  ScrollViewForHeader.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 30.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class ScrollViewForHeader: UIViewController {
    
    var farm: Farm? = nil
    
    var stackWidth = 0
    
    lazy var contentSize = CGSize(width: self.view.frame.width + 500, height: 65)
    
    lazy var  mainContainerView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var headerScrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 65))
        view.backgroundColor = .clear
//        view.frame = self.view.bounds
        view.autoresizingMask = .flexibleWidth
        view.bounces = true
        view.showsVerticalScrollIndicator = true
        view.contentSize = contentSize
        return view
    }()
    
    var mainStackView = UIStackView(arrangedSubviews: [], axis: .horizontal, spacing: 8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollViewLabesls(with: farm!)
        setupConstraints()
    }
    
    func setupScrollViewLabesls(with farm: Farm) {
        
        let coinsWithHash = farm.hashratesByCoin
        
        let sourceDict = ["WorkersOn": String(farm.workersCount),
                          "WorkersOff": String(farm.stats!.gpusOffline),
                          "GPU On": String(farm.stats!.gpusOnline),
                          "GPU Off": String(farm.stats!.gpusOffline),
                          "Effectivency": "\(farm.stats!.asr)%",
                          "Ballance": "\(farm.money!.balance)$",
                          "Daily cost": "\(farm.money!.dailyPrice)$",
                          "Consumation": "\(farm.stats!.powerDraw)W"
        ]
        
        for item in sourceDict {
            if !item.value.isEmpty && item.value != "0" {
                let arrangedView = createContainerViewForEachLabelPair(topLabelText: item.key,
                                                                       bottomLabelText: item.value)
                self.stackWidth += 100
                self.mainStackView.addArrangedSubview(arrangedView)
            }
        }
        coinsWithHash?.forEach({ coin in
            let arrangedView = createContainerViewForEachLabelPair(topLabelText: String(coin.coin),
                                                                   bottomLabelText: String(coin.hashrate))
            self.stackWidth += 100
            self.mainStackView.addArrangedSubview(arrangedView)
        })
    }
    
    func createContainerViewForEachLabelPair(topLabelText: String, bottomLabelText: String) -> UIView {

        let containerView: UIView = {
            let contntainer = UIView(frame: CGRect(x: 0, y: 0, width: 95, height: 65))
            contntainer.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2078431373, blue: 0.2352941176, alpha: 1)
            contntainer.layer.cornerRadius = 8
            return contntainer
        }()

        let topLabel = UILabel(text: topLabelText, font: .systemFont(ofSize: 14, weight: .regular), color: .white)
        let bottomLabel = UILabel(text: bottomLabelText, font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
        topLabel.adjustsFontSizeToFitWidth = true
        bottomLabel.adjustsFontSizeToFitWidth = true
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(topLabel)
        containerView.addSubview(bottomLabel)

        NSLayoutConstraint.activate([
            topLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            topLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 5),
            topLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
        ])

        NSLayoutConstraint.activate([
            bottomLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            bottomLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 5),
            bottomLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
        ])
        
        return containerView
    }
    
    func setupConstraints() {
        view.backgroundColor = .clear
        view.addSubview(headerScrollView)
        headerScrollView.addSubview(mainContainerView)
        mainContainerView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 5),
            mainStackView.widthAnchor.constraint(equalToConstant: CGFloat(stackWidth)),
            mainStackView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -5)
        ])
    }
}
