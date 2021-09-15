//
//  Double+extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 12.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation

extension Double {
    
    func toSiUnits() -> String {
        
        var stringInt = String(describing: Int(self))
        let lenghtOfInt = stringInt.count
        
        if (0...3).contains(lenghtOfInt) {
            stringInt = "\(stringInt)h/s"
        } else if (4...6).contains(lenghtOfInt) {
            stringInt = "\(String(format: "%.1f", (self/1000)))kh/s"
        } else if (7...9).contains(lenghtOfInt) {
            stringInt = "\(String(format: "%.1f", (self/1000000)))Mh/s"
        } else if (10...12).contains(lenghtOfInt) {
            stringInt = "\(String(format: "%.1f", (self/1000000000)))Gh/s"
        }
        return stringInt
    }
    
    func toSiUnitsAsETH() -> String {
        
        var stringInt = String(describing: Int(self))
        let lenghtOfInt = stringInt.count
        
        if (0...3).contains(lenghtOfInt) {
            stringInt = "\(String(format: "%.1f", (self)))h/s"
        } else if (4...6).contains(lenghtOfInt) {
            stringInt = "\(String(format: "%.1f", (self/1000)))Mh/s"
        } else if (7...9).contains(lenghtOfInt) {
            stringInt = "\(String(format: "%.1f", (self/1000000)))Gh/s"
        } else if (10...12).contains(lenghtOfInt) {
            stringInt = "\(String(format: "%.1f", (self/1000000000)))Th/s"
        }
        
        return stringInt
    }
}
