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
    
    func calculateWorkerUpTime(with value: Worker) -> String {
        interactor?.calculateWorkerUpTime(with: value) ?? ""
    }
    
    func prepareHeaderCellHeight(stacksHeights: [Int]) -> Int {
        (interactor?.prepareHeaderCellHeight(stacksHeights: stacksHeights))!
    }

}
