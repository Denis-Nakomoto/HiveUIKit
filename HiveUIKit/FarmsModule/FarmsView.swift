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

    var iconsImages = [String : UIImage]()
    
    // Var is used for cell height calculation
    var coinsCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        createDataSource()
        reloadData()
        coinsCount = 40 * iconsImages.count
        self.overrideUserInterfaceStyle = .dark
//        NetworkManager.shared.tokenRefresh()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(collectionView)
        collectionView.register(FarmCell.self, forCellWithReuseIdentifier: FarmCell.reuseId)
        collectionView.delegate = self
    }
    
    func dismissVC() {
        print(#function)
        self.dismiss(animated: true)
    }
    
    deinit {
        print("FARMS VC is deallocated")
    }
    
    @objc func logOut() {
        presenter?.logOut()
    }
}

// Setup layout
extension FarmsViewController {
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Your Farms"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logOut))
    }
}

// Setup compositional layout
extension FarmsViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(CGFloat(170 + self.coinsCount)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
            return section
        }
        return layout
    }
    
    //MARK: - Data source
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Farm>(collectionView: collectionView,
                                                                       cellProvider: { [weak self] (collectionView,
                                                                                                    indexPath, farm) -> UICollectionViewCell? in
                                                                        guard let section = Section(rawValue: indexPath.section) else {
                                                                            fatalError("Unknown section kind")
                                                                        }
                                                                        
                                                                        switch section {
                                                                        case .myFarms:
                                                                            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FarmCell.reuseId, for: indexPath) as? FarmCell
                                                                            else { fatalError() }
                                                                            //Captured weak self leaded to forse unwrap below!!!
                                                                            cell.setupLabelsData (with: (self?.farms.data[indexPath.row])!, and: self?.iconsImages ?? [:])
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
}

// Delegate extension for initiate workers fetching
extension FarmsViewController: UICollectionViewDelegate {
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            presenter?.didSelectItemAt(with: self.farms.data[indexPath.row].id)
        }
    
    func fetchFarmsSuccess() {
        // refresh control goes here
    }
    
    func fetchWorkersFailure(with error: String, and message: String) {
        self.showAlert(with: error, and: message)
    }
    
    
}
