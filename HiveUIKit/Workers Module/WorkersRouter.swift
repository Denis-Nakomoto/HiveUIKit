//
//  WorkersRouter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright (c) 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class WorkersRouter: WorkersRouterProtocol {
    
    static func createWorkersModule(with: Workers, farmId: Int, farmSelected: Farm) -> UIViewController {
        let view: WorkersViewProtocol = WorkersViewController()
        let presenter: WorkersPresenterProtocol = WorkersPresenter()
        
        view.workers = with
        view.farmId = farmId
        view.farm = farmSelected
        view.iconsImages = SceneDelegate.shared.rootViewController.iconsImages
        
        view.presenter = presenter
        view.presenter?.router = WorkersRouter()
        view.presenter?.view = view
        view.presenter?.interactor = WorkersInteractor()
        view.presenter?.interactor?.presenter = presenter
        
        return view as! UIViewController
    }
    
    func showRigModule(view: WorkersViewProtocol, rig: Worker, metrics: MetricsModel, messages: MessagesModel, heightsOfStacks: [Int]) {
        let rigViewController = RigRouter.createRigModule(rig: rig, metrics: metrics, messages: messages, heightsOfStacks: heightsOfStacks)
        let viewController = view as! WorkersViewController
        viewController.navigationController?.pushViewController(rigViewController, animated: true)
    }
    
}
