//
//  TableViewCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var reuseId: String {
        String(describing: self)
    }
    
    func setupCardView() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.backgroundColor = .black
    }

}
