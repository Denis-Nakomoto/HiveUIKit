//
//  FarmsPresenter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 21.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation

class FarmsPresenter: FarmsPresenterProtocol {
    
    var router: FarmsRouterProtocol?
    
    var interactor: FarmsInteractorProtocol?
    
    var view: FarmsViewProtocol?
    
    func didSelectItemAt(with farmId: Int) {
        interactor?.loadWorkers(with: farmId)
    }
    
    func fetchWorkersSuccess(workers: Workers) {
        print(#function)
        router?.pushToWorkersModule(on: view!, with: workers)
    }
    
    func fetchWorkersFailure(with error: String, and message: String) {
        print(#function)
        view?.fetchWorkersFailure(with: error, and: message)
    }
    
    func logOut() {
        interactor?.logOut()
    }
    
}

