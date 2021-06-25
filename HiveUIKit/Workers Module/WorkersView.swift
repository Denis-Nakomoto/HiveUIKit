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
    
    var showFullDetails = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WorkerCell.self, forCellReuseIdentifier: WorkerCell.reuseId)
        setupNavigationBar()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        overrideUserInterfaceStyle = .dark
        tableView.delegate = self
        tableView.dataSource = self
        showFullDetails = [Bool](repeating: false, count: workers?.data?.count ?? 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers?.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkerCell.reuseId, for: indexPath) as! WorkerCell
        
        if let workers = workers?.data {
            let stackHieghts = self.prepareIconAndGPUStacks(worker: workers[indexPath.row], and: self.iconsImages)
            let shortViewHeightAdd = prepareShortViewHeight(stacksHeights: stackHieghts)
            cell.shortViewHeigth += shortViewHeightAdd
            let upTime = self.calculateWorkerUpTime(with: (self.workers?.data![indexPath.row])!)
            cell.shortView.setupWorkerShortView(with: workers[indexPath.row], and: iconsImages, stackHieghts: stackHieghts, upTime: upTime)
            
            if showFullDetails[indexPath.row] {
                cell.detailedView.isHidden = false
                cell.detailedView.setupDatailedGPUView(with: workers[indexPath.row])
                return cell
            } else {
                cell.detailedView.isHidden = true
                return cell
            }
        }
        else { fatalError("Impossible to fetch workers") }
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
    
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int {
        (presenter?.prepareHeaderCellHeight(stacksHeights: stacksHeights))!
    }
    
}

extension WorkersViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? WorkerCell else { return }
        print(showFullDetails)
        showFullDetails[indexPath.row].toggle()
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        self.tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if showFullDetails[indexPath.row] {
            return UITableView.automaticDimension
        } else { return 100 }
        
    }
}
