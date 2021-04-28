//
//  FarmsView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 21.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class FarmsViewController: UIViewController, FarmsViewProtocol {
    
    enum Section: Int, CaseIterable {
        case myFarms
    }
    
    var presenter: FarmsPresenterProtocol?
    
    var dataSource: UICollectionViewDiffableDataSource <Section, Farm>?
    var collectionView: UICollectionView!
    
    var farms = Farms(data: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        createDataSource()
        reloadData()
        setupUI()
        view.backgroundColor = .systemBlue
    }
    
    deinit {
        print("FARMS VC is allocated")
    }
    
    //MARK: - Data source
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Farm>(collectionView: collectionView,
                                                                        cellProvider: { (collectionView,
                                                                                         indexPath, farm) -> UICollectionViewCell? in
                                                                            guard let section = Section(rawValue: indexPath.section) else {
                                                                                fatalError("Unknown section kind")
                                                                            }
                                                                            
                                                                            switch section {
                                                                            case .myFarms:
                                                                                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FarmCell.reuseId, for: indexPath) as? FarmCell
                                                                                else { fatalError() }
                                                                                cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                                                                                cell.setupLabelsData (with: self.farms.data[indexPath.row])
                                                                                return cell
                                                                            }
                                                                        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Farm>()
        snapshot.appendSections([.myFarms])
        snapshot.appendItems(farms.data, toSection: .myFarms)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
//    @IBAction @objc func logOut(_ sender: Any) {
//        let _ = KeychainWrapper.standard.removeObject(forKey: "accessToken")
//    }
}

extension FarmsViewController {
    
    func setupUI() {
        
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Your Farms"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .darkGray
        view.addSubview(collectionView)
        collectionView.register(FarmCell.self, forCellWithReuseIdentifier: "farmCell")
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
