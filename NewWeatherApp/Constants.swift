//
//  Constants.swift
//  NewWeatherApp
//
//  Created by Andriy Pryvalov on 10.09.16.
//  Copyright © 2016 Andriy Pryvalov. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "lon="
let APP_ID = "&appid="
let API_KEY = "b11d0188b6a8331823369d0fb27c4d57"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)35\(LONGITUDE)139\(APP_ID)\(API_KEY)"
let FORESCAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&mode=json&appid=b1b15e88fa797225412429c1c50c122a1"
