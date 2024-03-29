//
//  FarmsModuleContract.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 25.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

protocol FarmsViewProtocol: AnyObject {
    var presenter: FarmsPresenterProtocol? { get set }
    
    var farms: Farms { get set }
    var iconsImages: [String : UIImage] { get set }
    
//    func fetchFarmsSuccess()
    func fetchWorkersFailure(with error: String, and message: String)

}

protocol FarmsInteractorProtocol: AnyObject {
    var presenter: FarmsPresenterProtocol? { get set }
    
    func loadWorkers(with farmId: Int)
    
    func logOut() 
    
}

protocol FarmsPresenterProtocol: AnyObject {
    var router: FarmsRouterProtocol? { get set }
    var interactor: FarmsInteractorProtocol? { get set }
    var view: FarmsViewProtocol? { get set}
    
    func didSelectItemAt(with farmId: Int)
    func fetchWorkersSuccess(workers: Workers, farmId: Int, farmSelected: Farm)
    func fetchWorkersFailure(with error: String, and message: String)
    
    func logOut()

}

protocol FarmsRouterProtocol: AnyObject {
    
    static func createFarmsModule(with farms: Farms) -> UIViewController
    
    func pushToWorkersModule(on view: FarmsViewProtocol, with workers: Workers, farmId: Int, farmSelected: Farm)
}
