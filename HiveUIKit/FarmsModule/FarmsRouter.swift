//
//  FarmsRouter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 21.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class FarmsRouter: FarmsRouterProtocol {

    static func createFarmsModule(with farms: Farms) -> UIViewController {
        let view: FarmsViewProtocol = FarmsViewController()
        view.farms = farms
        
        if SceneDelegate.shared.rootViewController.iconsImages.isEmpty {
            CoinsIconsFetchSevice.shared.getIconsForCoinsInUse(with: farms, completion: { icons in
            view.iconsImages = icons
        })
        } else {
            view.iconsImages = SceneDelegate.shared.rootViewController.iconsImages
        }
        
        let presenter: FarmsPresenterProtocol = FarmsPresenter()
        
        view.presenter = presenter
        view.presenter?.router = FarmsRouter()
        view.presenter?.view = view
        view.presenter?.interactor = FarmsInteractor()
        view.presenter?.interactor?.presenter = presenter
        
        return view as! UIViewController

    }
    
    func pushToWorkersModule(on view: FarmsViewProtocol, with workers: Workers, farmId: Int, farmSelected: Farm) {
        let workersViewController = WorkersRouter.createWorkersModule(with: workers, farmId: farmId, farmSelected: farmSelected)
            
        let viewController = view as! FarmsViewController
        viewController.navigationController?
            .pushViewController(workersViewController, animated: true)
    }
}



