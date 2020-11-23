//
//  WorkerCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 11.11.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import UIKit

class WorkerCell: UICollectionViewCell {
    
    static var reuseId: String = "workerCell"
    var name = UILabel(text: "NAME", color: #colorLiteral(red: 0.5490196078, green: 0.7411764706, blue: 0.9568627451, alpha: 1))
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}

extension WorkerCell {
    private func setupConstraints() {
        
        name.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(name)
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: self.topAnchor),
            name.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            name.heightAnchor.constraint(equalToConstant: 6),
            name.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
