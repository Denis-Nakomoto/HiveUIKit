//
//  Layout.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

final class FormCompositionalLayout {
    
    var layout: UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(420))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        let compLayout = UICollectionViewCompositionalLayout(section: section)
        return compLayout
    }
    
}
