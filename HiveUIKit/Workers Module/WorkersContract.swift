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
    var iconsImages:[String : UIImage] { get set }
    func convertTime(with value: Int?) -> String
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int
    func refreshWorkers()
    func onRefreshWorkersSuccess(workers: Workers)
    func onRefreshWorkersFailure(with: String, and: String)
}

protocol WorkersInteractorProtocol: AnyObject {
    var presenter: WorkersPresenterProtocol? { get set }
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
    func convertTime(with value: Int?) -> String
    func dateFormatter(from timestamp: String) -> String
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int
    func refreshWorkers(farmId: Int)
}

protocol WorkersPresenterProtocol: AnyObject {
    var router: WorkersRouterProtocol? { get set }
    var interactor: WorkersInteractorProtocol? { get set }
    var view: WorkersViewProtocol? { get set}
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
    func convertTime(with value: Int?) -> String
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int
    func refreshWorkers(farmId: Int)
    func refreshWorkersSuccess(workers: Workers)
    func refreshWorkersFailure(with: String, and: String)
}

protocol WorkersRouterProtocol: AnyObject {
    
    static func createWorkersModule(with: Workers, farmId: Int) -> UIViewController 

}
