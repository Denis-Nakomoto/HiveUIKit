//
//  RigView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 31.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class RigViewController: UIViewController, RigViewProtocol {
    
    enum Section: Int, CaseIterable {
        case grigSection
        case gpuSection
        case metricSection
        case generalRigDataSection
    }

    var presenter: RigPresenterProtocol?
    
    var worker: Worker?
    var metrics: MetricsModel?
    var messages: MessagesModel?
    var heightsOfStacks: [Int]?
    
    private lazy var compLayout = FormCompositionalLayout()
    private lazy var dataSource = makeDataSource()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: compLayout.layout)
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
        setupConstraints()
        updateDateSource()
    }
    
    // Puts content to each section
    func formContentBuilder(worker: Worker, metrics: MetricsModel, messages: MessagesModel) -> [FormSectionComponent] {
        
        var gpuStatsItems: [GpuItem] = []
        var metricsItems: [MetricsItem] = []
        var algoArray: [String] = []
        
        if let gpuStats = worker.gpuStats {
            gpuStats.forEach { gpuStatsItems.append(GpuItem(worker: $0)) }
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
    
}

extension RigViewController {
    
    func setupConstraints() {
        view.backgroundColor = .white
        collectionView.dataSource = dataSource
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<FormSectionComponent, FormComponent> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case is RigItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralRigDataCell.reuseId, for: indexPath) as! GeneralRigDataCell
                cell.bind(item, heightsOfStacks: self.heightsOfStacks!)
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
            
            if let wrkr = self.worker, let mtrs = self.metrics, let msgs = self.messages {
                let formSections = self.formContentBuilder(worker: wrkr, metrics: mtrs, messages: msgs)
                snapshot.appendSections(formSections)
                formSections.forEach { snapshot.appendItems($0.items, toSection: $0) }
                self.dataSource.apply(snapshot, animatingDifferences: animated)
            }
            
        }
    }
}
