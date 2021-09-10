//
//  RigCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 02.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class GeneralRigDataCell: UICollectionViewCell, StacksAndViewsPreparableProtocol {

    var worker: Worker?
    var messages: [Messages]?
    var iconAndHashStacksHeightAdd: CGFloat = 0
    var detailedViewHeightAdd: CGFloat = 0
    
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    
//    let workerName = UILabel(text: "WorkerName", font: .systemFont(ofSize: 14, weight: .regular), color: .white)
    let powerConsumingIcon = UIImageView(image: UIImage(named: "bolt.fill"))
    var allConinsHashrateAndIconsStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 5)
    let powerConsuming = UILabel(text: "Consumation", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.1960784314, green: 0.5882352941, blue: 0.8392156863, alpha: 1))
    
    let detailedView = DetailedWorkerView()
    
    let messagesStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 5)
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
    }
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        setupCardView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }

    func bind(_ item: FormComponent) {
        guard let item = item as? RigItem else { return }
        setup(item: item)
    }
    
    func setupCellData(with worker: Worker, and icons: [String : UIImage]) {
        configureCoinsStack(with: worker, and: icons, on: allConinsHashrateAndIconsStack)
        powerConsuming.text = "\(worker.stats!.powerDraw ?? 0) W"
    }
    
}

extension GeneralRigDataCell {
    
    func setup(item: RigItem) {
        self.worker = item.rig
        self.messages = item.messages
    }
    
    func setupConstraints() {
        contentView.backgroundColor = .black
        let powerStack = UIStackView(arrangedSubviews: [powerConsumingIcon, powerConsuming], axis: .horizontal, spacing: 3)
        
//        workerName.translatesAutoresizingMaskIntoConstraints = false
        powerStack.translatesAutoresizingMaskIntoConstraints = false
        allConinsHashrateAndIconsStack.translatesAutoresizingMaskIntoConstraints = false
        gradientBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        detailedView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(gradientBackgroundView)
//        addSubview(workerName)
        addSubview(allConinsHashrateAndIconsStack)
        addSubview(detailedView)
        allConinsHashrateAndIconsStack.distribution = .fillEqually
        allConinsHashrateAndIconsStack.alignment = .leading
        addSubview(powerStack)
        powerStack.distribution = .fill
        
        NSLayoutConstraint.activate([
            gradientBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            gradientBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            powerStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            powerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            allConinsHashrateAndIconsStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            allConinsHashrateAndIconsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            allConinsHashrateAndIconsStack.widthAnchor.constraint(equalToConstant: 200),
            allConinsHashrateAndIconsStack.heightAnchor.constraint(equalToConstant: CGFloat(iconAndHashStacksHeightAdd + 40))
        ])
        
        NSLayoutConstraint.activate([
            detailedView.topAnchor.constraint(equalTo: allConinsHashrateAndIconsStack.bottomAnchor, constant: 8),
            detailedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            detailedView.heightAnchor.constraint(equalToConstant: detailedViewHeightAdd + 335)
        ])
    }
    
}
