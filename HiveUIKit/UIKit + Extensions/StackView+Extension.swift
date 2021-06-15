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
    
        func addGradientBackground() {
            let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
            gradientBackgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(gradientBackgroundView, at: 0)
        }
}
