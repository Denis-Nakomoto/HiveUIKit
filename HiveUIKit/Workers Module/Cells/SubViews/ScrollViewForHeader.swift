//
//  ScrollViewForHeader.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 30.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class ScrollViewForHeader: UIViewController {
    
    var farm: Farm?
    
    var stackWidth = 0
    
    lazy var contentSize = CGSize(width: self.view.frame.width + 30, height: 65)
    
    lazy var  mainContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.frame.size = contentSize
        view.backgroundColor = .black
        return view
    }()
    
    lazy var headerScrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 65))
        view.backgroundColor = .black
        view.autoresizingMask = .flexibleWidth
        view.bounces = true
        view.showsHorizontalScrollIndicator = false
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
        
        var iterrationsCounter = 0
        
        let sourceDict = ["WorkersOn": String(farm.workersCount),
                          "WorkersOff": String(farm.stats!.gpusOffline),
                          "GPU On": String(farm.stats!.gpusOnline),
                          "GPU Off": String(farm.stats!.gpusOffline),
                          "Effectivency": "\(farm.stats!.asr)%",
                          "Ballance": "\(farm.money!.balance)$",
                          "Daily cost": "\(farm.money!.dailyPrice)$",
                          "Consumation": "\(farm.stats!.powerDraw)W"
        ]
        
        let sourceArray = ["WorkersOn", "WorkersOff", "GPU On","GPU Off",
                          "Effectivency", "Ballance", "Daily cost", "Consumation"
        ]
        
        for item in sourceArray {
            let dictValue = sourceDict[item]
            if !(dictValue?.isEmpty ?? true) && dictValue != "0" {
                let arrangedView = createContainerViewForEachLabelPair(topLabelText: item,
                                                                       bottomLabelText: dictValue!)
                iterrationsCounter += 1
                self.stackWidth += 100
                // Add to scroll view width
                if iterrationsCounter > 3 {
                    mainContainerView.frame.size.width += CGFloat(100)
                    headerScrollView.contentSize.width += CGFloat(100)
                }
                self.mainStackView.addArrangedSubview(arrangedView)
            }
        }
        
        coinsWithHash?.forEach({ coin in
            let arrangedView = createContainerViewForEachLabelPair(topLabelText: String(coin.coin),
                                                                   bottomLabelText: coin.hashrate.toSiUnitsAsETH())
            self.stackWidth += 100
            // Add to scroll view width
            mainContainerView.frame.size.width += CGFloat(100)
            headerScrollView.contentSize.width += CGFloat(100)
            self.mainStackView.addArrangedSubview(arrangedView)
        })
    }
    
    func createContainerViewForEachLabelPair(topLabelText: String, bottomLabelText: String) -> UIView {

        let containerView: UIView = {
            let contntainer = UIView(frame: CGRect(x: 0, y: 0, width: 95, height: 55))
            contntainer.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2078431373, blue: 0.2352941176, alpha: 1)
            contntainer.layer.cornerRadius = 8
            return contntainer
        }()

        let topLabel = UILabel(text: topLabelText, font: .systemFont(ofSize: 14, weight: .light), color: .white)
        let bottomLabel = UILabel(text: bottomLabelText, font: .systemFont(ofSize: 14, weight: .thin), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
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
            mainStackView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor,constant: 8),
            mainStackView.widthAnchor.constraint(equalToConstant: CGFloat(stackWidth)),
            mainStackView.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor,constant: -8)
        ])
    }
}
