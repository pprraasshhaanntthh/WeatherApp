//
//  HourlyForecastViewController.swift
//  WeatherMobileApp
//
//  Created by Prashanth on 06/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import AppCenterAnalytics

class HourlyForecastViewController: UITableViewController, CLLocationManagerDelegate {
    
    var hourlyForecasts = [HourlyForecast]()
    
    var hourlyForecast: HourlyForecast!
    let currentWeather = CurrentWeather()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }
    
    func locationAuthStatus(){
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            downloadHourlyForecastData {}
            
            // MARK: Stop updating location
            locationManager.stopUpdatingLocation()
            
        }else{
            print("non authorized")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationAuthStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        
        // Only called when variable have location data
        locationAuthStatus()
    }
    
    func downloadHourlyForecastData(completed: @escaping DownloadComplete){
        Alamofire.request(HOURLY_WEATHER_URL, method: .get).responseJSON{ (responce) in
            
            let result = responce.result
            if self.hourlyForecasts.count < 24{
                if let dict = result.value as? Dictionary<String,Any>{
                    if let list = dict["list"] as? [Dictionary<String, Any>]{
                        for obj in list{
                            self.hourlyForecast = HourlyForecast(forecastDict:obj)
                            self.hourlyForecasts.append(self.hourlyForecast)
                        }
                    }
                    if let city = dict["city"] as? Dictionary<String,Any>{
                        if let name = city["name"] as? String{
                            self.navigationItem.title = name
                        }
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func updateHourlyTVAfterChangeSettings(){
        hourlyForecasts.removeAll()
        if hourlyForecasts.count == 0 { print("updated suckesuly") }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyForecasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyId", for: indexPath) as? HourlyForecastTableViewCell{
            let hourly = hourlyForecasts[indexPath.row]
            cell.configureCell(hourlyForecast: hourly)
            return cell
        }else{
            return HourlyForecastTableViewCell()
        }
    }
    
    @IBAction func updateForecastInHourlyTVController(_ sender: Any) {
        MSAnalytics.trackEvent("Hourly Status Refresh")
        hourlyForecasts.removeAll()
        tableView.reloadData()
        viewDidAppear(true)
    }

}
