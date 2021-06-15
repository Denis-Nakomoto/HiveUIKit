//
//  Int+Extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 28.05.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation

extension Int {
    
    func  fromUnixTimeStamp() -> Date? {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date
    }
}
