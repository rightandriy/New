//
//  WeatherVC.swift
//  NewWeatherApp
//
//  Created by Andriy Pryvalov on 10.09.16.
//  Copyright © 2016 Andriy Pryvalov. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation


class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    
    @IBOutlet weak var weatherLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    
    
    
    
    var currentWeather = CurrentWeather()
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.DownloadWeatherDetails {
                self.downloadForecastData {
                    self.updateNameUI()
                }
            }
            
            
        }else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData (completed: @escaping DownloadComplete){
        //Downloading forecast weather data for tableVIew
        
        Alamofire.request(FORECAST_URL).responseJSON{ respons in
            let result = respons.result
            
            if let dict = result.value as? Dictionary <String, Any> {
                
                if let list = dict["list"] as? [Dictionary <String, Any>]{
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
                
            }
            completed()
    }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
        
        
        return cell
        }else {
            return WeatherCell()
        }
    }
    
    func updateNameUI() {
        dateLbl.text = currentWeather.date
        temperatureLbl.text = "\(currentWeather.currentTemp)"
        weatherLbl.text = currentWeather.weatherType
        placeLbl.text = currentWeather.cityName
        forecastImage.image = UIImage(named: currentWeather.weatherType)
        
    }

}

