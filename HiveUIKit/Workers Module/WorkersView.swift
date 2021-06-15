//
//  WorkersView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright (c) 2021 Denis Svetlakov. All rights reserved.

import UIKit
import SwiftKeychainWrapper


class WorkersViewController: UITableViewController, WorkersViewProtocol {

    var presenter: WorkersPresenterProtocol?
    
    var workers: Workers?
    
    var iconsImages = [String : UIImage]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WorkerCell.self, forCellReuseIdentifier: WorkerCell.reuseId)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupNavigationBar()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        overrideUserInterfaceStyle = .dark
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers?.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkerCell.reuseId, for: indexPath) as! WorkerCell
        if let workers = workers?.data {
            let stackHieghts = self.prepareIconAndGPUStacks(worker: workers[indexPath.row], and: self.iconsImages)
            let cellHeightAdd = prepareHeaderCellHeight(stacksHeights: stackHieghts)
            cell.cellHeight += cellHeightAdd
            let upTime = self.calculateWorkerUpTime(with: (self.workers?.data![indexPath.row])!)
            cell.setupWorkerCell(with: workers[indexPath.row], and: iconsImages, stackHieghts: stackHieghts, upTime: upTime)
        } else { fatalError("Impossible to fetch workers") }
        return cell
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Your Workers"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int] {
        return presenter?.prepareIconAndGPUStacks(worker: worker, and: icons) ?? []
    }
    
    func calculateWorkerUpTime(with value: Worker) -> String {
        presenter?.calculateWorkerUpTime(with: value) ?? ""
    }
    
    func prepareHeaderCellHeight(stacksHeights: [Int]) -> Int {
        (presenter?.prepareHeaderCellHeight(stacksHeights: stacksHeights))!
    }
    
}

extension WorkersViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WorkerCell else {
              return
            }
        if let workers = workers?.data {
        cell.isExpanded = !cell.isExpanded
            if cell.isExpanded {
                cell.cellHeight += 200
            } else {
                cell.cellHeight -= 200
            }
        cell.setupDatailedGPUView(with: workers[indexPath.row])
        }
    }
//
//    xtension AuteurDetailViewController: UITableViewDelegate {
//      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      // 1
//      guard let cell = tableView.cellForRow(at: indexPath) as? FilmTableViewCell else {
//        return
//      }
//
//      var film = selectedAuteur.films[indexPath.row]
//
//      // 2
//      film.isExpanded = !film.isExpanded
//      selectedAuteur.films[indexPath.row] = film
//
//      // 3
//      cell.moreInfoTextView.text = film.isExpanded ? film.plot : moreInfoText
//      cell.moreInfoTextView.textAlignment = film.isExpanded ? .left : .center
//      cell.moreInfoTextView.textColor = film.isExpanded ?
//        UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0) :
//        .red
//
//      // 4
//      tableView.beginUpdates()
//      tableView.endUpdates()
//
//      // 5
//      tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//     }
//    }
}

//
//class WorkersViewController: UIViewController, WorkersViewProtocol {
//
//    enum Section: Int, CaseIterable {
//        case myWorkers
//    }
//
//    var presenter: WorkersPresenterProtocol?
//
//    var workers: Workers?
//
//    var iconsImages = [String : UIImage]()
//
//
//    var dataSource: UICollectionViewDiffableDataSource <Section, Worker>?
//    var collectionView: UICollectionView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar()
//        setupCollectionView()
//        createDataSource()
//        reloadData()
//        self.overrideUserInterfaceStyle = .dark
//    }
//
//    private func setupCollectionView() {
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        view.addSubview(collectionView)
//        collectionView.register(WorkerCell.self, forCellWithReuseIdentifier: WorkerCell.reuseId)
//        collectionView.delegate = self
//    }
//
//    deinit {
//        print("Workers VC is deallocated")
//    }
//}
//
//// Setup layout
//extension WorkersViewController {
//
//    private func setupNavigationBar() {
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationController?.navigationBar.barTintColor = .black
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
//        navigationItem.leftBarButtonItem = backButton
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationItem.title = "Your Workers"
//        navigationController?.navigationBar.prefersLargeTitles = true
////        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
////                                                            style: .plain,
////                                                            target: self,
////                                                            action: #selector(logOut))
//    }
//}
//
//// Setup compositional layout
//extension WorkersViewController {
//
//    private func createCompositionalLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                  heightDimension: .fractionalHeight(1))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                   heightDimension: .absolute(CGFloat(80)))
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.interGroupSpacing = 8
//            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
//            return section
//        }
//        return layout
//    }
//
//    //MARK: - Data source
//    private func createDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section,
//                                                        Worker>(collectionView: collectionView,
//                                                                cellProvider: { [weak self] (collectionView, indexPath, worker) -> UICollectionViewCell? in
//                                                                    guard let section = Section(rawValue: indexPath.section) else {
//                                                                        fatalError("Unknown section kind")
//                                                                    }
//
//                                                                    switch section {
//                                                                    case .myWorkers:
//                                                                        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkerCell.reuseId, for: indexPath) as? WorkerCell,
//                                                                        let stackHieghts = self?.prepareIconAndGPUStacks(worker: (self?.workers?.data![indexPath.row])!, and: self?.iconsImages ?? [:])
//                                                                        else { fatalError() }
//                                                                        cell.configureLabels(with: (self?.workers?.data?[indexPath.row])!, and: self?.iconsImages ?? [:])
//                                                                        cell.setupConstraints(heightsOfStacks: stackHieghts)
//                                                                        return cell
//                                                                    }
//                                                                })
//    }
//
//    private func reloadData() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Worker>()
//        snapshot.appendSections([.myWorkers])
//        snapshot.appendItems((workers?.data)!, toSection: .myWorkers)
//        dataSource?.apply(snapshot, animatingDifferences: true)
//    }
//
//    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int] {
//        return presenter?.prepareIconAndGPUStacks(worker: worker, and: icons) ?? []
//    }
//}
//
//extension WorkersViewController: UICollectionViewDelegate {
//
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////            guard let farm = self.dataSource?.itemIdentifier(for: indexPath) else { return }
////            presenter?.didSelectItemAt(with: self.Workers.data[indexPath.row].id)
//        }
//
//    func fetchWorkersSuccess() {
//        // refresh control goes here
//    }
//
//    func fetchWorkersFailure(with error: String, and message: String) {
//        self.showAlert(with: error, and: message)
//    }
//
//}
