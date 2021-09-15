//
//  WorkersView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright (c) 2021 Denis Svetlakov. All rights reserved.

import UIKit

class WorkersViewController: UITableViewController, WorkersViewProtocol, TransitionToRigProtocol, AutoRefreshable {

    var presenter: WorkersPresenterProtocol?
    
    var workers: Workers?
    
    var farm: Farm?
    
    var farmId: Int?
    
    var iconsImages = [String : UIImage]()
    
    var showFullDetails = [Bool]()
    
    lazy var workersRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshWorkers), for: .allEvents)
        return refreshControl
    } ()

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
        tableView.addSubview(workersRefreshControl)
        refreshWorker()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers?.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkerCell.reuseId, for: indexPath) as! WorkerCell
        
        // Set delegate for to rig transition on button press
        cell.shortView.showRigViewDelegate = self
        
        if let workers = workers?.data {
            // Set worker ID to be able terform transition to particular rig ob button press in th cell
            cell.shortView.workerId = workers[indexPath.row].id
            cell.shortView.farmId = farm?.id
            let stackHieghts = self.prepareIconAndGPUStacks(worker: workers[indexPath.row], and: self.iconsImages)
            let shortViewHeightAdd = prepareShortViewHeight(stacksHeights: stackHieghts)
            let detailedViewHieghtAdd = prepareDetailedViewHeight(worker: workers[indexPath.row])
            // Calculating adds for cell to fit the conte1z
            
            if (workers[indexPath.row].minersSummary?.hashrates!.count) ?? 1 > 1 {
                cell.detailedViewHeigth += ((46 * (workers[indexPath.row].minersSummary?.hashrates!.count ?? 1)) - 46)
            }
            
            cell.shortViewHeigth += shortViewHeightAdd
            cell.detailedViewHeigth += detailedViewHieghtAdd
            cell.detailedView.gpuStackHeighAdd += detailedViewHieghtAdd
            // Calculete worker and miner boot time
            var minerBootTime = ""
            let workerBootTime = self.convertTime(with: (self.workers?.data![indexPath.row].stats?.bootTime))
            if let minerTime = (self.workers?.data![indexPath.row].stats?.minerStartTime) {
            minerBootTime = self.convertTime(with: minerTime)
            }
            cell.shortView.setupWorkerShortView(with: workers[indexPath.row], and: iconsImages, stackHieghts: stackHieghts, upTime: workerBootTime)
            if showFullDetails[indexPath.row] {
                cell.detailedView.isHidden = false
                cell.detailedView.setupWorkerDetailedView(with: workers[indexPath.row], workerBootTime: workerBootTime, minerBootTime: minerBootTime)
//                cell.detailedView.minerInfoField.setData(worker: workers[indexPath.row])
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Your Workers"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    // Calculates height of the icons and hashrate stack and GPU stack for short view of the cell
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int] {
        return presenter?.prepareIconAndGPUStacks(worker: worker, and: icons) ?? []
    }
    // Converts unix time recieved from server to normal format
    func convertTime(with value: Int?) -> String {
        presenter?.convertTime(with: value) ?? ""
    }
    // Finally calculates short view height
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int {
        (presenter?.prepareShortViewHeight(stacksHeights: stacksHeights))!
    }
    // Calculates Detailed view height of the cell
    func prepareDetailedViewHeight(worker: Worker) -> Int {
        presenter?.prepareDetailedViewHeight(worker: worker) ?? 0
    }
    
    // Pull to refresh methods
    
    @objc func refreshWorkers() {
        presenter?.refreshWorkers(farmId: self.farmId!)
    }
    
    func onRefreshWorkersSuccess(workers: Workers, farm: Farm) {
        self.workers = workers
        self.farm = farm
        self.tableView.reloadData()
        self.workersRefreshControl.endRefreshing()
    }

    func onRefreshWorkersFailure(with: String, and: String) {
        self.showAlert(with: "Error", and: "Something went wrong. Cannot refresh workers")
        self.workersRefreshControl.endRefreshing()
    }
    
    // Method of the TransitionToRigProtocol
    func showRigView(rigId: Int, farmId: Int, icons: [String : UIImage]) {
        presenter?.showRigView(rigId: rigId, farmId: farmId, icons: icons)
    }
}

extension WorkersViewController {
    
    // Show/hide details view
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(showFullDetails)
        showFullDetails[indexPath.row].toggle()
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        self.tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if showFullDetails[indexPath.row] {
            return UITableView.automaticDimension
        } else { return 95 }
        
    }
}

// Header with horisontal scroll view in section

extension WorkersViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let scrollView = ScrollViewForHeader()
        
        if let frm = farm {
            scrollView.farm = frm
        }

        return scrollView.view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}
