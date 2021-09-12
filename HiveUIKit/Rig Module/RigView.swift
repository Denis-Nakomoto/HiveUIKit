//
//  RigView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 31.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class RigViewController: UIViewController, RigViewProtocol, CompositionalLayoutCreatable {
    
    var presenter: RigPresenterProtocol?
    
    var worker: Worker?
    var metrics: MetricsModel?
    var messages: MessagesModel?
    var icons: [String : UIImage]?
    var sections: [FormSectionComponent]?
    
    private lazy var dataSource = createDataSource()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseId)
        cv.register(GeneralRigDataCell.self, forCellWithReuseIdentifier: GeneralRigDataCell.reuseId)
        cv.register(GpusCell.self, forCellWithReuseIdentifier: GpusCell.reuseId)
        cv.register(MetricsCell.self, forCellWithReuseIdentifier: MetricsCell.reuseId)
        cv.register(GeneralDataCell.self, forCellWithReuseIdentifier: GeneralDataCell.reuseId)
        return cv
    }()
    
    override func loadView() {
        super.loadView()
        navigationItem.title = worker?.name
        setupConstraints()
        updateDateSource()
        if let wrkr = worker, let mtrs = metrics, let msgs = messages {
            sections = formContentBuilder(worker: wrkr, metrics: mtrs, messages: msgs)
        }
    }
    
    // Puts content to each section
    func formContentBuilder(worker: Worker, metrics: MetricsModel, messages: MessagesModel) -> [FormSectionComponent] {
        
        var gpuStatsItems: [GpuItem] = []
        var metricsItems: [MetricsItem] = []
        var algoArray: [String] = []
        
        if let gpuStats = worker.gpuStats, let gpuInfo = worker.gpuInfo {
            for (stat, info) in zip(gpuStats, gpuInfo) {
                gpuStatsItems.append(GpuItem(gpuStat: stat, gpuInfo: info))
            }
        }
        
        metrics.data.forEach { algo in
            for item in algo.hashrates {
                if !algoArray.contains(item.algo) {
                    algoArray.append(item.algo)
                }
            }
        }
        
        algoArray.forEach { metricsItems.append(MetricsItem(metrics: Hash(algo: $0, values: [])))}
        
        var content: [FormSectionComponent] {
            
            return [
                FormSectionComponent(items: [RigItem(rig: worker, messages: messages.data)]),
                FormSectionComponent(items: gpuStatsItems),
                FormSectionComponent(items: metricsItems),
                FormSectionComponent(items: [GeneralWorkerInfo(info: worker)])
            ]
        }
        return content
    }
    
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int] {
        return presenter?.prepareIconAndGPUStacks(worker: worker, and: icons) ?? []
    }
    
}

extension RigViewController {
    
    func setupConstraints() {
        view.backgroundColor = .black
        collectionView.dataSource = dataSource
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func createDataSource() -> UICollectionViewDiffableDataSource<FormSectionComponent, FormComponent> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case is RigItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralRigDataCell.reuseId, for: indexPath) as! GeneralRigDataCell
                cell.bind(item)
                self.setupGeneralRigDataCell(on: cell)
                return cell
            case is GpuItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GpusCell.reuseId, for: indexPath) as! GpusCell
                cell.bind(item)
                return cell
            case is MetricsItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetricsCell.reuseId, for: indexPath) as! MetricsCell
                cell.bind(item)
                cell.buildChart(metrics: self.metrics)
                return cell
            case is GeneralWorkerInfo:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralDataCell.reuseId, for: indexPath) as! GeneralDataCell
                cell.bind(item)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseId, for: indexPath)
                return cell
            }
        }
    }
    
    func updateDateSource(animated: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<FormSectionComponent, FormComponent>()
            guard let sections = self.sections else { return }
            snapshot.appendSections(sections)
            sections.forEach { snapshot.appendItems($0.items, toSection: $0) }
            self.dataSource.apply(snapshot, animatingDifferences: animated)
        }
    }
    
    // Set data for general rig data cell
    func setupGeneralRigDataCell(on cell: GeneralRigDataCell) {
        if let worker = self.worker, let icons = self.icons {
            cell.setupCellData(with: worker, and: icons)
            // Use the same method which for short worker view but without gpu stack
            let iconAndHashStacksHeightAdd = prepareIconAndGPUStacks(worker: worker, and: icons)
            let i = iconAndHashStacksHeightAdd.last!
            cell.iconAndHashStacksHeightAdd += CGFloat(i)
            
            let detailedViewHieghtAdd = prepareDetailedViewHeight(worker: worker)
            cell.detailedViewHeightAdd += CGFloat(detailedViewHieghtAdd)
            // Calculates worker and miner boot time
            var minerBootTime = ""
            let workerBootTime = convertTime(with: (worker.stats?.bootTime))
            if let minerTime = (worker.stats?.minerStartTime) {
                minerBootTime = convertTime(with: minerTime)
                cell.detailedView.setupWorkerDetailedView(with: worker,
                                                          workerBootTime: workerBootTime,
                                                          minerBootTime: minerBootTime)
            }
            cell.detailedView.minerInfoField.setData(worker: worker)
        }
    }
    
    // Calculates Detailed view height
    func prepareDetailedViewHeight(worker: Worker) -> Int {
        presenter?.prepareDetailedViewHeight(worker: worker) ?? 0
    }
    
    // Converts unix time recieved from server to normal format
    func convertTime(with value: Int?) -> String {
        presenter?.convertTime(with: value) ?? ""
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch self.sections![sectionIndex].items.first {
            case is RigItem:
                return self.createRigSection()
            case is GpuItem:
                return self.createGpuSection()
            case is MetricsItem:
                return self.createMetricsSection()
            case is GeneralWorkerInfo:
                return self.createGeneralWorkerInfo()
            default:
                return self.createRigSection()
            }
        }
        return layout
    }
    
}


