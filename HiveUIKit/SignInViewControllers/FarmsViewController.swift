//
//  FarmViewController.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 30.10.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.

import UIKit
import SwiftKeychainWrapper

//struct MChat: Hashable, Decodable {
//    var username: String
//    var lastMessage: String
//    var id: Int
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//
//    static func == (lhs: MChat, rhs: MChat) -> Bool {
//        return lhs.id == rhs.id
//    }
//}

//class FarmViewController: UIViewController {
//    
//    var farms: [Farms] = []
//    var dataSource: UICollectionViewDiffableDataSource <Section, Farm>?
//    var collectionView: UICollectionView!
//    
//    enum Section: Int, CaseIterable {
//        case myFarms
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar()
//        setupCollectionView()
//        createDataSource()
//        reloadData()
//    }
//    
//    //    let activeChats: [MChat] = [
//    //        MChat(username: "Alexey", lastMessage: "How are you?", id: 1),
//    //    ]
//    
//    //MARK: - Data source
//    private func createDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section, Farm>(collectionView: collectionView,
//                                                                        cellProvider: { (collectionView,
//                                                                                         indexPath, farm) -> UICollectionViewCell? in
//                                                                            guard let section = Section(rawValue: indexPath.section) else {
//                                                                                fatalError("Unknown section kind")
//                                                                            }
//                                                                            
//                                                                            switch section {
//                                                                            case .myFarms:
//                                                                                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FarmCell.reuseId, for: indexPath) as? FarmCell
//                                                                                else { fatalError() }
//                                                                                cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//                                                                                cell.setupLabelsData (with: self.farms.first!.data[indexPath.row])
//                                                                                return cell
//                                                                            }
//                                                                        })
//    }
//    
//    private func reloadData() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Farm>()
//        snapshot.appendSections([.myFarms])
//        snapshot.appendItems(farms.first!.data, toSection: .myFarms)
//        dataSource?.apply(snapshot, animatingDifferences: true)
//    }
//    
//    @IBAction @objc func logOut(_ sender: Any) {
//        let _ = KeychainWrapper.standard.removeObject(forKey: "accessToken")
//    }
//}
//
//// MARK: - Setup layout
//extension FarmsViewController {
//    
//    private func setupNavigationBar() {
//        navigationController?.navigationBar.barTintColor = .darkGray
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationItem.title = "Your Farms"
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
//    
//    private func setupCollectionView() {
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        collectionView.backgroundColor = .darkGray
//        view.addSubview(collectionView)
//        collectionView.register(FarmCell.self, forCellWithReuseIdentifier: "farmCell")
//        collectionView.delegate = self
//    }
//    
//    private func createCompositionalLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                  heightDimension: .fractionalHeight(1))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                   heightDimension: .absolute(140))
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//            
//            let section = NSCollectionLayoutSection(group: group)
//            section.interGroupSpacing = 8
//            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
//            return section
//        }
//        return layout
//    }
//}
//
//extension FarmsViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let farm = self.dataSource?.itemIdentifier(for: indexPath) else { return }
//        //        guard let section = Section (rawValue: indexPath.section) else { return }
//        let workersVC = WorkersViewController()
//        let vc = UINavigationController(rootViewController: workersVC)
//        let _ = NetworkManager.shared.fetchWorkerData(with: "https://api2.hiveos.farm/api/v2/farms/\(farm.id)/workers") { workers in
//            workersVC.workers = workers.data ?? []
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, animated: true, completion: nil)
//        }
//    }
//}

// MARK: - SwiftUI
//import SwiftUI
//
//struct FarmVCProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        let viewController = FarmsViewController()
//
//        func makeUIViewController(context: UIViewControllerRepresentableContext<FarmVCProvider.ContainerView>) -> FarmsViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: FarmVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<FarmVCProvider.ContainerView>) {
//
//        }
//    }
//}
