//
//  GpusCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class GpusCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
        contentView.backgroundColor = .green
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

