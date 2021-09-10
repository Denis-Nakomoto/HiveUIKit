//
//  DateAndTimeConvertors.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 07.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

protocol DatePrepareableProtocol {
    
    func convertTime(with value: Int?) -> String
    func dateFormatter(from timestamp: String) -> String
}


extension DatePrepareableProtocol {
    
    
    
    // Calculates time of work for each worker
    // TODO: It would great to reafactor it
    func convertTime(with value: Int?) -> String {
        
        var bootTime: [String] = []
        
        let interval = Date() - (value!.fromUnixTimeStamp()!)
        
        if let months = interval.month, interval.month != 0 {
            bootTime.append("\(months)M:")
        }
        
        if let days = interval.day, interval.day != 0 {
            if days >= 30 {
                bootTime.append("\(days % 30)d:")
            } else {
                bootTime.append("\(days)d:")
            }
        }
        
        if let hours = interval.hour, interval.hour != 0 {
            if hours >= 24 {
                bootTime.append("\(hours % 24)h:")
            } else {
                bootTime.append("\(hours)h:")
            }
        }
        
        if let minutes = interval.minute, interval.minute != 0 {
            if minutes >= 60 {
                bootTime.append("\(minutes % 60)m")
            } else {
                bootTime.append("\(minutes)m")
            }
        }
        
        return bootTime.joined()
    }
    
    // Converts unix date in normal format
    
    func dateFormatter(from timestamp: String) -> String {
        if let timeInterval = TimeInterval(timestamp) {
            let date = Date(timeIntervalSince1970: timeInterval)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy HH:mm:ss"
            return formatter.string(from: date)
        }
        return ""
    }
}
