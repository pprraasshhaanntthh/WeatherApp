//
//  DateExtension.swift
//  WeatherMobileApp
//
//  Created by Prashanth on 06/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import Foundation

extension Date{
    
    func Days() -> String{
        let dataFormatter = DateFormatter()
        dataFormatter.dateStyle = .short
        dataFormatter.dateFormat = "EEEE"
        return dataFormatter.string(from: self)
    }
    
    func Hourly() -> String{
        let dataFormatter = DateFormatter()
        dataFormatter.dateStyle = .short
        dataFormatter.dateFormat = "HH:00"
        return dataFormatter.string(from: self)
    }
    
}
