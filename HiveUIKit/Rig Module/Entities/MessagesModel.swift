//
//  MessagesModel.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 02.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct MessagesModel: Codable {
    let data: [Messages]
    let pagination: Pagination
}

// MARK: - Datum
struct Messages: Codable {
    let id: Int
    let type: String
    let time: Int
    let title: String
    let hasPayload: Bool
//    let cmdID: Int

    enum CodingKeys: String, CodingKey {
        case id, type, time, title
        case hasPayload = "has_payload"
//        case cmdID = "cmd_id"
    }
}

struct Pagination: Codable {
    let total, count, perPage, currentPage: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}

enum MessageTypes: String {
    case success = "success"
    case info = "info"
    case file = "file"
    case warning = "warning"
    case danger = "danger"
}
