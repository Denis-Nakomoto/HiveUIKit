//
//  WorkersViewController.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 11.11.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class WorkersViewController: UIViewController {
    
    var workers: [Workers] = []
    var dataSource: UICollectionViewDiffableDataSource <Section, Workers>?
    var collectionView: UICollectionView!
    
//    enum WorkerItem: Hashable {
//        case header(Workers)
//        case cell(Workers)
//    }
    
    enum Section: Int, CaseIterable {
        case myWorkers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        createDataSource()
        reloadData()
    }
    
    //MARK: - Data source
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Workers>(collectionView: collectionView,
                                                                        cellProvider: { (collectionView,
                                                                                         indexPath, farm) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
                                                                            
            switch section {
            case .myWorkers:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkerCell.reuseId, for: indexPath) as? WorkerCell
                else { fatalError() }
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                cell.setupLabelsData (with: self.farm.data[indexPath.row])
                return cell
            }
        })
        dataSource?.supplementaryViewProvider = {
           collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorkerViewHeader.reuseID, for: indexPath) as? WorkerViewHeader
            else { fatalError("cannot create new section header") }
            guard let section = Section(rawValue: indexPath.section)
            else { fatalError("Unknown section kind")}
            return sectionHeader
        }
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Workers>()
        snapshot.appendSections([.myWorkers])
        snapshot.appendItems(workers, toSection: .myWorkers)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Setup layout
extension WorkersViewController {
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Your Workers"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .darkGray
        view.addSubview(collectionView)
        collectionView.register(WorkerViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WorkerViewHeader.reuseID)
        collectionView.register(WorkerCell.self, forCellWithReuseIdentifier: WorkerCell.reuseId)
        //        collectionView.delegate = self
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(140))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)

            let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))

            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                            elementKind: UICollectionView.elementKindSectionHeader,
                                                                            alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]

            return section
        }
        return layout
    }
}
