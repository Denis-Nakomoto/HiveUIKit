//
//  GeneralDataCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class GeneralDataCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
        contentView.backgroundColor = .systemYellow
    }

    func bind(_ item: FormComponent) {
        guard let item = item as? GeneralWorkerInfo else { return }
        setup(item: item)
    }
    
}

extension GeneralDataCell {
    
    func setup(item: GeneralWorkerInfo) {
        
    }
    
}
