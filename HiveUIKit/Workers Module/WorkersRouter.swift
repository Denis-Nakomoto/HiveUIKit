//
//  WorkersRouter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright (c) 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class WorkersRouter: WorkersRouterProtocol {
    
    static func createWorkersModule(with: Workers) -> UIViewController {
        let view: WorkersViewProtocol = WorkersView()
        let presenter: WorkersPresenterProtocol = WorkersPresenter()
        
        view.presenter = presenter
        view.presenter?.router = WorkersRouter()
        view.presenter?.view = view
        view.presenter?.interactor = WorkersInteractor()
        view.presenter?.interactor?.presenter = presenter
        
        return view as! UIViewController
    }
}
