//
//  WorkersContract.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright (c) 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

protocol WorkersViewProtocol: AnyObject {
    var presenter: WorkersPresenterProtocol? { get set }
    var workers: Workers? { get set }
    var farmId: Int? { get set }
    var farm: Farm? { get set }
    var iconsImages:[String : UIImage] { get set }
    func convertTime(with value: Int?) -> String
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int
    func refreshWorkers()
    func onRefreshWorkersSuccess(workers: Workers, farm: Farm)
    func onRefreshWorkersFailure(with: String, and: String)
    func prepareDetailedViewHeight(worker: Worker) -> Int
}

protocol WorkersInteractorProtocol: AnyObject {
    var presenter: WorkersPresenterProtocol? { get set }
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
    func convertTime(with value: Int?) -> String
    func dateFormatter(from timestamp: String) -> String
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int
    func refreshWorkers(farmId: Int)
    func showRigView(rigId: Int, farmId: Int)
    func prepareDetailedViewHeight(worker: Worker) -> Int
}

protocol WorkersPresenterProtocol: AnyObject {
    var router: WorkersRouterProtocol? { get set }
    var interactor: WorkersInteractorProtocol? { get set }
    var view: WorkersViewProtocol? { get set}
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
    func convertTime(with value: Int?) -> String
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int
    func refreshWorkers(farmId: Int)
    func refreshWorkersSuccess(workers: Workers, farm: Farm)
    func refreshWorkersFailure(with: String, and: String)
    func showRigView(rigId: Int, farmId: Int)
    func showRigViewSuccess(rig: Worker)
    func prepareDetailedViewHeight(worker: Worker) -> Int
}

protocol WorkersRouterProtocol: AnyObject {
    
   func showRigModule(view: WorkersViewProtocol, rig: Worker)

}

protocol TransitionToRigProtocol {
    func showRigView(rigId: Int, farmId: Int)
}
