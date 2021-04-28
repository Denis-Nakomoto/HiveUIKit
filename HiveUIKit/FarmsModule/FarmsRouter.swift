//
//  FarmsRouter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 21.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class FarmsRouter: FarmsRouterProtocol {
    
    
    static func createFarmsModule(with farms: Farms) -> UINavigationController {
        let view = FarmsViewController()
        view.farms = farms
        let navigationController = UINavigationController(rootViewController: view)
//        (UIApplication.shared.delegate as? SceneDelegate)?.window?.rootViewController = navigationController
        
        let presenter: FarmsPresenterProtocol = FarmsPresenter()
        
        view.presenter = presenter
        view.presenter?.router = FarmsRouter()
        view.presenter?.view = view
        view.presenter?.interactor = FarmsInteractor()
        view.presenter?.interactor?.presenter = presenter
        
        return navigationController

    }
    
    func pushToWorkersModule(on view: FarmsViewProtocol, with workers: Workers) {
//        let workerViewController = WorkerRouter.createModule(with: workers)
//            
//        let viewController = view as! FarmsViewController
//        viewController.navigationController?
//            .pushViewController(workerViewController, animated: true)
    }
    
    
    
}



