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
    var heightsOfStacks: [Int]? { get set }
//    var rigSummary: RigDataSourceModel? { get set }
}

protocol RigInteractorProtocol: AnyObject {
    var presenter: RigPresenterProtocol? { get set }
}

protocol RigPresenterProtocol: AnyObject {
    var router: RigRouterProtocol? { get set }
    var interactor: RigInteractorProtocol? { get set }
    var view: RigViewProtocol? { get set}
}

protocol RigRouterProtocol: AnyObject {
    
    static func createRigModule(rig: Worker, metrics: MetricsModel, messages: MessagesModel, heightsOfStacks: [Int]) -> UIViewController

}
