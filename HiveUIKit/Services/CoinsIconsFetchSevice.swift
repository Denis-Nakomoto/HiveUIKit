//
//  CoinsFetchSevice.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 08.05.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved

import UIKit

// MARK: - The only task of the class is to provide app with icons of the coins currently in mining

final class CoinsIconsFetchSevice {
    
    static let shared = CoinsIconsFetchSevice()
    let dispatchGroupAllCoins = DispatchGroup()
    let dispatchGroupIcons = DispatchGroup()
    let queueAllCoins = DispatchQueue(label: "DonloadIconsUrls")
    let queueAllIcons = DispatchQueue(label: "DonloadCoinIconsImages", qos: .userInitiated )
    
    var allIcons: [Icons] = []
    
    private struct Constants {
        static let apiKey = "811363D0-6A09-4B4F-B957-6642CB1EB391"
        static let url = "https://rest-sandbox.coinapi.io/v1/assets/icons/55"
    }
    
    init() {}
    
    // MARK: - Fetches array of all coins icons from API
    
    func fetchAllCoinsIcons() {
        dispatchGroupAllCoins.enter()
        guard let url = URL(string: Constants.url + "?apikey=" + Constants.apiKey) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            defer { self?.dispatchGroupAllCoins.leave() }
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
    
    // MARK: - Filters array of all coins/icons removing all unused coins
    
    func filter(_ farms: Farms) -> [Icons] {
        var iconsInUse:[Icons] = []
        // Define all coins mined by the farm in the moment
        let coinsMined = farms.data
            .map { $0.hashratesByCoin }
            .compactMap { $0 }
            .flatMap { $0 }
        iconsInUse = CoinsIconsFetchSevice.shared.allIcons.filter { icon in
            coinsMined.contains(where: { $0.coin == icon.name })}
        // If icon of the coin is not found in API list than his logo will be covered with dymmy logo
        for coin in coinsMined {
            iconsInUse.map { icon in
                if icon.name != coin.coin {
                    iconsInUse.append(Icons(name: coin.coin, url: "DummyCoin")) }
            }
        }
        return iconsInUse
    }
    
    // MARK: - Gets actual UIImages of the coins icons
    
    func fetchIconsImages(with urls: [Icons], completion: @escaping(_ icons: [String: UIImage]) -> Void) {
        dispatchGroupIcons.enter()
            var coinsInUse: [String: UIImage] = [:]
            if urls.isEmpty {
                completion(coinsInUse)
            }
            // Check if the coin logo image is already stored in user defaults
            for url in urls {
                if let dict = UserDefaults.standard.object(forKey: "CoinsCache") as? [String:String] {
                    if let path = dict[url.url!] {
                        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                            let img = UIImage(data: data)
                            coinsInUse[url.name] = img
                            completion(coinsInUse)
                        }
                    }
                }
                // If logo is not stored locally than proceed with logo request from server and save it in user defaults
                var taskUrl = URL(string: url.url!)
                if url.url == "DummyCoin" {
                    let path = Bundle.main.path(forResource: "DummyCoin", ofType: "png")
                    taskUrl = URL(fileURLWithPath: path!)
                } else {
                    taskUrl = URL(string: url.url!)
                }
                let task = URLSession.shared.dataTask(with: taskUrl!, completionHandler: { data, _, _ in
                    defer { self.dispatchGroupIcons.leave() }
                    if let data = data {
                        if let image = UIImage(data: data) {
                            self.storeCoinImageInCache(urlString: url.url!, image: image)
                            coinsInUse[url.name] = UIImage(data: data) ?? UIImage(named: "DummyCoin")
                        } else {
                            self.storeCoinImageInCache(urlString: url.url!, image: UIImage(named: "DummyCoin")!)
                            coinsInUse[url.name] = UIImage(named: "DummyCoin")
                        }
                    }
                })
                task.resume()
                dispatchGroupIcons.notify(queue: DispatchQueue.main) {
                    completion(coinsInUse)
                }
            }
    }
    
    // MARK: - Gets array of coins names and their icons which are currently in mining by the farm
    
    func getIconsForCoinsInUse(with farms: Farms, completion: @escaping(_ icons: [String: UIImage]) -> Void) {
        dispatchGroupAllCoins.notify(queue: DispatchQueue.global()) { [weak self] in
            if let iconsInUse = self?.filter(farms) {
                self?.fetchIconsImages(with: iconsInUse) { icons in
                    completion(icons)
                }
            }
        }
    }
    
    // MARK: - Stores coins logos locally in user defaults
    
    func storeCoinImageInCache(urlString: String, image: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        let data = image.pngData()
        
        try? data?.write(to: url)
        var dict = UserDefaults.standard.object(forKey: "CoinsCache") as? [String:String]
        if dict == nil {
            dict = [String:String]()
        }
        dict![urlString] = path
        UserDefaults.standard.setValue(dict, forKey: "CoinsCache")
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
