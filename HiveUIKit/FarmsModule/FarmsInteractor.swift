//
//  FarmsInteractor.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 21.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class FarmsInteractor: FarmsInteractorProtocol {
    
    var presenter: FarmsPresenterProtocol?
    
}
//protocol AnyInteractor {
//    var presenter: AnyPresenter? { get set }
//    
//    func getUsers()
//}
//
//class FarmInteractor: AnyInteractor {
//    var presenter: AnyPresenter?
//    
//    func getUsers() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
//        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
//            guard let data = data, error == nil else {
//                self?.presenter?.interatorDidFetchFarms(with: .failure(FetchError.failed))
//                return
//            }
//            do {
//                let entities = try JSONDecoder().decode([User].self, from: data)
//                self?.presenter?.interatorDidFetchFarms(with: .success(entities))
//            }
//            catch {
//                self?.presenter?.interatorDidFetchFarms(with: .failure(FetchError.failed))
//            }
//        }.resume()
//    }
//}
