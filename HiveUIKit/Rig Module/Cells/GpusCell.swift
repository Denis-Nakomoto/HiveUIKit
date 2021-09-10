//
//  GpusCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class GpusCell: UICollectionViewCell {
    
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
        contentView.backgroundColor = .green
    }
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        setupCardView()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    func bind(_ item: FormComponent) {
        guard let item = item as? GpuItem else { return }
        setup(item: item)
    }
    
}

extension GpusCell {
    
    func setup(item: GpuItem) {
        
    }
    
}

