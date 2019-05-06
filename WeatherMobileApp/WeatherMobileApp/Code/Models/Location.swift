//
//  Location.swift
//  WeatherMobileApp
//
//  Created by Prashanth on 04/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import Foundation

/// Ccan store the loction information for latitude and longtitude
class Location{
    
    private var _latitude: Double!
    private var _longitude: Double!
    
    private init() {}
    
    static var sharedInstance = Location()
    
    var latitude: Double{
        get{
            if _latitude == nil{
                _latitude = 0.0
            }
            return _latitude
        }
        set{_latitude =  newValue}
    }
    var longitude: Double{
        get{
                if _longitude == nil{
                _longitude = 0.0
            }
            return _longitude
        }
        set{_longitude = newValue}
    }
    
}
