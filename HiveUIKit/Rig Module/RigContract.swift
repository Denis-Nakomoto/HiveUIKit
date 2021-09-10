//
//  RigContract.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 31.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

protocol RigViewProtocol: AnyObject {
    var presenter: RigPresenterProtocol? { get set }
    var worker: Worker? { get set }
    var metrics: MetricsModel? { get set }
    var messages: MessagesModel? { get set }
    var icons: [String : UIImage]? { get set }
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
    func prepareDetailedViewHeight(worker: Worker) -> Int
    func convertTime(with value: Int?) -> String
}

protocol RigInteractorProtocol: AnyObject {
    var presenter: RigPresenterProtocol? { get set }
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
    func prepareDetailedViewHeight(worker: Worker) -> Int
    func convertTime(with value: Int?) -> String
}

protocol RigPresenterProtocol: AnyObject {
    var router: RigRouterProtocol? { get set }
    var interactor: RigInteractorProtocol? { get set }
    var view: RigViewProtocol? { get set}
    
    func prepareIconAndGPUStacks(worker: Worker, and icons: [String : UIImage]) -> [Int]
    func prepareDetailedViewHeight(worker: Worker) -> Int
    func convertTime(with value: Int?) -> String
    
}

protocol RigRouterProtocol: AnyObject {
    
    static func createRigModule(rig: Worker, metrics: MetricsModel, messages: MessagesModel, icons: [String : UIImage]) -> UIViewController

}
