//
//  MetricsModel.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 02.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//


import Foundation

struct MetricsModel: Codable {
    let data: [Metrics]
}

struct Metrics: Codable {
    let time, units: Int
    let temp, fan: [Int]
    let power: Int
    let powerList: [Int]
    let hashrates: [Hash]

    enum CodingKeys: String, CodingKey {
        case time, units, temp, fan, power
        case powerList = "power_list"
        case hashrates
    }
}

struct Hash: Codable, Hashable {
    let algo: String
    let values: [Int]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(algo)
    }
    
    static func == (lhs: Hash, rhs: Hash) -> Bool {
        lhs.algo == rhs.algo
    }
}
