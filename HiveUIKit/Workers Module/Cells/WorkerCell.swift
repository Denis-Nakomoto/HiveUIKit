//
//  WorkerCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 12.06.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class WorkerCell: UITableViewCell {
    
    var shortView = ShortWorkerView()
    var detailedView = DetailedWorkerView()
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    var shortViewHeigth = 95
    var detailedViewHeigth = 350
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCardView()
        
        selectionStyle = .none
        addSubview(gradientBackgroundView)
        contentView.addSubview(shortView)
        contentView.addSubview(detailedView)
        gradientBackgroundView.layer.cornerRadius = 15
        gradientBackgroundView.clipsToBounds = true
        
        shortView.translatesAutoresizingMaskIntoConstraints = false
        detailedView.translatesAutoresizingMaskIntoConstraints = false
        gradientBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shortView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            shortView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            shortView.heightAnchor.constraint(equalToConstant: CGFloat(shortViewHeigth)),
            shortView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailedView.topAnchor.constraint(equalTo: shortView.bottomAnchor),
            detailedView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            detailedView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            detailedView.heightAnchor.constraint(equalToConstant: CGFloat(detailedViewHeigth)),
            detailedView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gradientBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            gradientBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            gradientBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            gradientBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
        
    }
    
}
