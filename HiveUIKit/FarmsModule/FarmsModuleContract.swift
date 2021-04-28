//
//  FarmsModuleContract.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 25.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

protocol FarmsViewProtocol: class {
    var presenter: FarmsPresenterProtocol? { get set }
    
    // TODO:
    // Pull to refresh control
    // logout button
    // View collection delegate
    // Review cell design

}

protocol FarmsInteractorProtocol: class {
    var presenter: FarmsPresenterProtocol? { get set }
    
    // TODO:
    // View refresher
    // Fetch workers logic
    //

}

protocol FarmsPresenterProtocol: class {
    var router: FarmsRouterProtocol? { get set }
    var interactor: FarmsInteractorProtocol? { get set }
    var view: FarmsViewProtocol? { get set}
    
    // TODO:
    // Refresh view reference
    // Logout refernece
    // Open workers page

}

protocol FarmsRouterProtocol: class {
    
    static func createFarmsModule(with farms: Farms) -> UINavigationController
    
    func pushToWorkersModule(on view: FarmsViewProtocol, with workers: Workers)
}
