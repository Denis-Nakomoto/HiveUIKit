//
//  WorkersPresenter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright (c) 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class WorkersPresenter: WorkersPresenterProtocol {

    var router: WorkersRouterProtocol?
    
    var interactor: WorkersInteractorProtocol?
    
    var view: WorkersViewProtocol?
    
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int] {
        interactor?.prepareIconAndGPUStacks(worker: worker, and: icons) ?? []
    }
    
    func convertTime(with value: Int?) -> String {
        interactor?.convertTime(with: value) ?? ""
    }
    
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int {
        (interactor?.prepareShortViewHeight(stacksHeights: stacksHeights))!
    }
    
    // Pull to refresh methods
    
    func refreshWorkers(farmId: Int) {
        interactor?.refreshWorkers(farmId: farmId)
    }
    
    func refreshWorkersSuccess(workers: Workers, farm: Farm) {
        view?.onRefreshWorkersSuccess(workers: workers, farm: farm)
    }
    
    func refreshWorkersFailure(with: String, and: String) {
        view?.onRefreshWorkersFailure(with: with, and: and)
    }
    
    func showRigView(rigId: Int, farmId: Int, heightsOfStacks: [Int]) {
        interactor?.showRigView(rigId: rigId, farmId: farmId, heightsOfStacks: heightsOfStacks)
    }
    
    func showRigViewSuccess(rig: Worker, metrics: MetricsModel, messages: MessagesModel, heightsOfStacks: [Int]) {
        router?.showRigModule(view: view!, rig: rig, metrics: metrics, messages: messages, heightsOfStacks: heightsOfStacks)
    }
    
    func prepareDetailedViewHeight(worker: Worker) -> Int {
        interactor?.prepareDetailedViewHeight(worker: worker) ?? 0
    }
    
}
