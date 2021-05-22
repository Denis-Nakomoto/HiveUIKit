//
//  LoginRouter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 23.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    
    static func createLoginModule() -> UIViewController {
        print("Create login \(#function)")
        let view = LoginView()
        
        let presenter: LoginPresenterProtocol = LoginPresenter()
        
        view.presenter = presenter
        view.presenter?.router = LoginRouter()
        view.presenter?.view = view
        view.presenter?.interactor = LoginInteractor()
        view.presenter?.interactor?.presenter = presenter
        
        return view
    }
    
    func pushToFarmsModule(on view: LoginViewProtocol, with farms: Farms) {
        print(#function)
            let farmsVC = FarmsRouter.createFarmsModule(with: farms)
            let viewController = view as! LoginView
            viewController.navigationController?
                .pushViewController(farmsVC, animated: true)
    }
}

