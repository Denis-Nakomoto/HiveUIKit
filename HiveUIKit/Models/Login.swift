//
//  Login.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 28.10.2020.
//  Copyright © 2020 Denis Svetlakov. All rights reserved.
//

import Foundation

struct Login: Codable {
    
    var login: String?
    var password: String?
    var twofaCode: String?
    var accessToken: String?
    
    enum  CodingKeys: String, CodingKey {
        case login
        case password
        case twofaCode = "twofa_code"
        case accessToken = "access_token"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(login, forKey: .login)
        try container.encode(password, forKey: .password)
        try container.encode(twofaCode, forKey: .twofaCode)
    }
}
