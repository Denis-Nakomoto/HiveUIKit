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

}

protocol WorkersInteractorProtocol: class {
    var presenter: WorkersPresenterProtocol? { get set }

}

protocol WorkersPresenterProtocol: class {
    var router: WorkersRouterProtocol? { get set }
    var interactor: WorkersInteractorProtocol? { get set }
    var view: WorkersViewProtocol? { get set}

}

protocol WorkersRouterProtocol: class {
    
    static func createWorkersModule(with: Workers) -> UIViewController 

}
