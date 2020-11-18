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
    
    var farmId: Int
    var workers: [Workers] = []
    var dataSource: UICollectionViewDiffableDataSource <Section, Workers>?
    var collectionView: UICollectionView!
    
    enum Section: Int, CaseIterable {
        case myWorkers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        createDataSource()
//        reloadData()
        fetchWorkerData(with: farmId)
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
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workerCell", for: indexPath) as? FarmCell
                else { fatalError() }
                cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//                cell.setupLabelsData (with: self.farm.data[indexPath.row])
                return cell
            }
        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Workers>()
        snapshot.appendSections([.myWorkers])
//        snapshot.appendItems(farm.first!.data, toSection: .myWorkers)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    init(farm: Datum) {
        self.farmId = farm.id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Fetch workers data
    private func fetchWorkerData(with farmId: Int) {
        NetworkManager.shared.fetchWorkerData(with: "https://api2.hiveos.farm/api/v2/farms/\(farmId)/workers") { workers in
            self.workers = workers.data ?? []
//            print(self.workers)
        }
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
        collectionView.register(FarmCell.self, forCellWithReuseIdentifier: "workerCell")
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
            return section
        }
        return layout
    }
}
