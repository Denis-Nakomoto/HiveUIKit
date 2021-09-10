//
//  CardTypeContainerView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 10.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit


class CardTypeContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCardTypeContainerView (cards: String, qty: String, brand: UIColor, spacing: CGFloat) {
        
        let cardType = UILabel(text: cards, font: .systemFont(ofSize: 14, weight: .regular), color: brand)
        let cardQty = UILabel(text: "x\(qty)", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
        let typeOfGpuStack = UIStackView(arrangedSubviews: [], axis: .horizontal, spacing: 2)
        
        typeOfGpuStack.distribution = .fillProportionally
        
        typeOfGpuStack.addArrangedSubview(cardType)
        typeOfGpuStack.addArrangedSubview(cardQty)
        addSubview(typeOfGpuStack)
        
        typeOfGpuStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeOfGpuStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            typeOfGpuStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            typeOfGpuStack.heightAnchor.constraint(equalTo: heightAnchor),
            typeOfGpuStack.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}
