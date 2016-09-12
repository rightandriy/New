//
//  Location.swift
//  NewWeatherApp
//
//  Created by Andriy Pryvalov on 12.09.16.
//  Copyright © 2016 Andriy Pryvalov. All rights reserved.
//

import Foundation
import CoreLocation


class Location {
   static var  sharedInstance = Location()
    private init(){
        
    }
    
    var latitude: Double!
    var longitude: Double!
}
