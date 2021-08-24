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
    
    func refreshWorkersSuccess(workers: Workers) {
        view?.onRefreshWorkersSuccess(workers: workers)
    }
    
    func refreshWorkersFailure(with: String, and: String) {
        view?.onRefreshWorkersFailure(with: with, and: and)
    }
    


}
