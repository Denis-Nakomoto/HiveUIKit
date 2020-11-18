//
//  StackView+Extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 09.11.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
    
}
