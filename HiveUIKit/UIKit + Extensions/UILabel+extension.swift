//
//  UILabel+extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 04.11.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .boldSystemFont(ofSize: 18), color: UIColor = .white) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
    }
}
