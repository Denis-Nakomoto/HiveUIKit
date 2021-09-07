//
//  XAxisValuesFormatter.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 07.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Charts

class XAxisValuesFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
       
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, h:mm a"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale.current
            return formatter
        }()
        
        if let dateFormattedValue = Int(value * 300).fromUnixTimeStamp() {
            return formatter.string(from: dateFormattedValue)
        } else {
            return ""
        }
    }
}


