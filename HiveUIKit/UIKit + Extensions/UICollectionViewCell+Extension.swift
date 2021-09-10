//
//  UICollectionViewCell+Extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 02.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseId: String {
        String(describing: self)
    }
    
    func removeViews() {
        contentView.subviews.forEach { $0.removeFromSuperview()}
    }
    
    func setupCardView() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.backgroundColor = .black
    }
}
