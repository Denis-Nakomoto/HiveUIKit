//
//  CustomActivityIndicator.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 25.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit


class CustomActivityIndicator: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rect = self.bounds
        
    }
    
}
