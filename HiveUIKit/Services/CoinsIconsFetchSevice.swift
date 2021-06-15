//
//  CoinsFetchSevice.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 08.05.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//
// 90f9f2d4bca38397eac8141441e29d2f388f7b7ea554e396bf072294f9a7f27c
// https://www.cryptocompare.com/


import UIKit

// MARK: - The only task of the class is to provide app with icons of the coins currently in mining

final class CoinsIconsFetchSevice {
    
    static let shared = CoinsIconsFetchSevice()
    
    var allIcons: [Icons] = []
    
    private struct Constants {
        static let apiKey = "811363D0-6A09-4B4F-B957-6642CB1EB391"
        static let url = "https://rest-sandbox.coinapi.io/v1/assets/icons/55"
    }
    
    init() {}
    
    // MARK: - Fetches array of all coins icons from API
    
    func fetchAllCoinsIcons() {
        print(#function)
        guard let url = URL(string: Constants.url + "?apikey=" + Constants.apiKey) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let icons = try JSONDecoder().decode([Icons].self, from: data)
                self?.allIcons = icons
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    // MARK: - Filters array of all coins/icons from all unused coins
    
    func filter(_ farms: Farms) -> [Icons] {
        var iconsInUse:[Icons] = []
        let coinsMined = farms.data
            .map { $0.hashratesByCoin }
            .compactMap { $0 }
            .flatMap { $0 }
        iconsInUse = CoinsIconsFetchSevice.shared.allIcons.filter { icon in coinsMined.contains(where: { $0.coin == icon.name })}
        return iconsInUse
    }
    
    // MARK: - Gets actual UIImages of the coins icons
    
    func fetchIconsImages(with urls: [Icons], completion: @escaping(_ icons: [String: UIImage]) -> Void) {
        let group = DispatchGroup()
        var coinsInUse: [String: UIImage] = [:]
        for url in urls {
            group.enter()
            let task = URLSession.shared.dataTask(with: URL(string: url.url!)!, completionHandler: { data, _, _ in
                if let data = data {
                    coinsInUse[url.name] = UIImage(data: data)!
                }
                group.leave()
            })
            task.resume()
        }
        group.notify(queue: DispatchQueue.main) {
            completion(coinsInUse)
        }
    }
    
    // MARK: - Gets array of coins names and their icons which are currently in mining by the farm
    
    func getIconsForCoinsInUse(with farms: Farms, completion: @escaping(_ icons: [String: UIImage]) -> Void) {
        print(#function)
        if CoinsIconsFetchSevice.shared.allIcons.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                let iconsInUse = self?.filter(farms)
                self?.fetchIconsImages(with: iconsInUse ?? []) { icons in
                    completion(icons)
                }
            }
        } else {
            let iconsInUse = filter(farms)
            self.fetchIconsImages(with: iconsInUse) { icons in
                completion(icons)
            }
        }
    }
}

// MARK: - Coins icons model

struct Icons: Decodable {
    
    let name: String
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "asset_id"
        case url
    }
}
