//
//  FarmsPresenter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 21.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation

class FarmsPresenter: FarmsPresenterProtocol {
    
    weak var router: FarmsRouterProtocol?
    
    var interactor: FarmsInteractorProtocol?
    
    weak var view: FarmsViewProtocol?
    
    func didSelectItemAt(with farmId: Int) {
        interactor?.loadWorkers(with: farmId)
    }
    
    func fetchWorkersSuccess(workers: Workers) {
        print(#function)
//        router?.presentWorkersModule(on: view!, with: workers)
//        view?.fetchFarmsSuccess()
    }
    
    func fetchWorkersFailure(with error: String, and message: String) {
        print(#function)
        view?.fetchWorkersFailure(with: error, and: message)
    }
    
    func logOut() {
        interactor?.logOut()
    }
    
}
//
//protocol  AnyPresenter {
//    var router: AnyRouter? { get set }
//    var interactor: AnyInteractor? { get set }
//    var view: AnyView? { get set}
//    
//    func interatorDidFetchFarms(with result: Result<[User], Error>)
//}
//
//class FarmPresenter: AnyPresenter {
//    var router: AnyRouter?
//    
//    var interactor: AnyInteractor? {
//        didSet{
//            interactor?.getUsers()
//        }
//    }
//    
//    var view: AnyView?
//    
//    func interatorDidFetchFarms(with result: Result<[User], Error>) {
//        switch result {
//        case .success(let users):
//            view?.update(with: users)
//        case .failure:
//            view?.update(with: "Somenthing went wrong")
//        }
//    }
//}
