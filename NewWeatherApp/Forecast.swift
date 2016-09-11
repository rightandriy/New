//
//  Forecast.swift
//  NewWeatherApp
//
//  Created by Andriy Pryvalov on 11.09.16.
//  Copyright © 2016 Andriy Pryvalov. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
        
    var date: String {
        if _date == nil {
            _date = ""
            
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
            
        }
        return _weatherType
    }
    
    var highTemp: String{
        if _highTemp == nil{
            _highTemp = ""
            
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil{
            _lowTemp = ""
            
        }
        return _lowTemp
    }
    
    init(weatherDict : Dictionary<String, Any>){
        
        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {
            if let min = temp["min"] as? Double{
              let kelvinToCelsium = (min - 273.15)
              self._lowTemp = "\(kelvinToCelsium)"
            }
            
            if let max = temp["max"] as? Double {
                let kelvinToCelsium = (max - 273.15)
                self._highTemp = "\(kelvinToCelsium)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>]{
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["Dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
}


extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
        
        
    }

}
