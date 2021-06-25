//
//  WorkersContract.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright (c) 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

protocol WorkersViewProtocol: class {
    var presenter: WorkersPresenterProtocol? { get set }
    var workers: Workers? { get set }
    var iconsImages:[String : UIImage] { get set }
    func calculateWorkerUpTime(with value: Worker) -> String
    func prepareShortViewHeight(stacksHeights: [Int]) -> Int
}

protocol WorkersInteractorProtocol: class {
    var presenter: WorkersPresenterProtocol? { get set }
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
    func calculateWorkerUpTime(with value: Worker) -> String
    func dateFormatter(from timestamp: String) -> String
    func prepareHeaderCellHeight(stacksHeights: [Int]) -> Int
}

protocol WorkersPresenterProtocol: class {
    var router: WorkersRouterProtocol? { get set }
    var interactor: WorkersInteractorProtocol? { get set }
    var view: WorkersViewProtocol? { get set}
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
    func calculateWorkerUpTime(with value: Worker) -> String
    func prepareHeaderCellHeight(stacksHeights: [Int]) -> Int 
}

protocol WorkersRouterProtocol: class {
    
    static func createWorkersModule(with: Workers) -> UIViewController 

}
