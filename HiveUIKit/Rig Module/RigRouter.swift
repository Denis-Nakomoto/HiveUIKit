//
//  RigRouter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 31.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class RigRouter: RigRouterProtocol {
    
    static func createRigModule(rig: Worker) -> UIViewController {
        
        let view: RigViewProtocol = RigViewController()
        let presenter: RigPresenterProtocol = RigPresenter()
        
        view.worker = rig
        view.presenter = presenter
        view.presenter?.router = RigRouter()
        view.presenter?.view = view
        view.presenter?.interactor = RigInteractor()
        view.presenter?.interactor?.presenter = presenter
        
        return view as! UIViewController
    }
}

