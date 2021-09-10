//
//  RigPresenter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 31.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class RigPresenter: RigPresenterProtocol {
    
    var router: RigRouterProtocol?
    
    var interactor: RigInteractorProtocol?
    
    var view: RigViewProtocol?
    
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int] {
        interactor?.prepareIconAndGPUStacks(worker: worker, and: icons) ?? []
    }
    
    func prepareDetailedViewHeight(worker: Worker) -> Int {
        interactor?.prepareDetailedViewHeight(worker: worker) ?? 0
    }
    
    func convertTime(with value: Int?) -> String {
        interactor?.convertTime(with: value) ?? ""
    }
    
}
