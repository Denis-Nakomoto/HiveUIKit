//
//  Sequence+Extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 09.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation

extension Sequence where Element: Hashable {
    var frequency: [Element: Int] { reduce(into: [:]) { $0[$1, default: 0] += 1 } }
}
