//
//  DaysForecastViewController.swift
//  WeatherMobileApp
//
//  Created by Prashanth on 06/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import AppCenterAnalytics

class DaysForecastViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    /// Contains the days foreccast data
    var dayForecasts = [DaysForecast]()
    var daysWeak = [DaysForecast]()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather = CurrentWeather()
    var dayForecast:DaysForecast!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    /// to verify the loccation auth status
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            locationManager.stopUpdatingLocation()
            self.downloadDaysForecastData {
            }
            // MARK: Stop updating location
        }else{
            print("non authorized DaysForecasrControll")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        // Only called when variable have location data
        locationAuthStatus()
    }
    
    /// To download &  parse the Days forecast for the current location
    ///
    /// - Parameter completed: a closure gets called once the operation is completed
    func downloadDaysForecastData(completed: @escaping DownloadComplete){
        Alamofire.request(FIVE_DAY_WEATHER_URL, method: .get).responseJSON{ (responce) in
            
            let result = responce.result
            if let dict = result.value as? Dictionary<String,Any>{
                if let list = dict["list"] as? [Dictionary<String, Any>]{
                    for obj in list{
                        self.dayForecast = DaysForecast(forecastDict:obj)
                        self.dayForecasts.append(self.dayForecast)
                    }
                    
                    var daySunday = [DaysForecast]()
                    var dayMonday = [DaysForecast]()
                    var dayTuesday = [DaysForecast]()
                    var dayWednesday = [DaysForecast]()
                    var dayThursday = [DaysForecast]()
                    var dayFriday = [DaysForecast]()
                    var daySaturday = [DaysForecast]()
                    
                    
                    for day in self.dayForecasts{
                        switch (day.dayOfTheWeak){
                            
                        case "Sunday":
                            daySunday.append(day)
                            
                        case "Monday":
                            dayMonday.append(day)
                            
                        case "Tuesday":
                            dayTuesday.append(day)
                            
                        case "Wednesday":
                            dayWednesday.append(day)
                            
                        case "Thursday":
                            dayThursday.append(day)
                            
                        case "Friday":
                            dayFriday.append(day)
                            
                        case "Saturday":
                            daySaturday.append(day)
                            
                        default:
                            print("Can not find this day of weak")
                        }
                        
                    }
                    
                    if self.daysWeak.count < 6 {
                        
                        if !daySunday.isEmpty {
                            
                            daySunday[0].minTemp = self.dayForecast.detectMinTempPerDay(daySunday)
                            daySunday[0].maxTemp = self.dayForecast.detectMaxTempPerDay(daySunday)
                            
                            self.daysWeak.append(daySunday[0])
                        }
                        if !dayMonday.isEmpty {
                            
                            dayMonday[0].minTemp = self.dayForecast.detectMinTempPerDay(dayMonday)
                            dayMonday[0].maxTemp = self.dayForecast.detectMaxTempPerDay(dayMonday)
                            
                            self.daysWeak.append(dayMonday[0])
                        }
                        if !dayTuesday.isEmpty {
                            
                            dayTuesday[0].minTemp = self.dayForecast.detectMinTempPerDay(dayTuesday)
                            dayTuesday[0].maxTemp = self.dayForecast.detectMaxTempPerDay(dayTuesday)
                            
                            self.daysWeak.append(dayTuesday[0])
                        }
                        if !dayWednesday.isEmpty {
                            
                            dayWednesday[0].minTemp = self.dayForecast.detectMinTempPerDay(dayWednesday)
                            dayWednesday[0].maxTemp = self.dayForecast.detectMaxTempPerDay(dayWednesday)
                            
                            self.daysWeak.append(dayWednesday[0])
                        }
                        if !dayThursday.isEmpty {
                            
                            dayThursday[0].minTemp = self.dayForecast.detectMinTempPerDay(dayThursday)
                            dayThursday[0].maxTemp = self.dayForecast.detectMaxTempPerDay(dayThursday)
                            
                            self.daysWeak.append(dayThursday[0])
                        }
                        if !dayFriday.isEmpty {
                            
                            dayFriday[0].minTemp = self.dayForecast.detectMinTempPerDay(dayFriday)
                            dayFriday[0].maxTemp = self.dayForecast.detectMaxTempPerDay(dayFriday)
                            
                            self.daysWeak.append(dayFriday[0])
                        }
                        if !daySaturday.isEmpty {
                            
                            daySaturday[0].minTemp = self.dayForecast.detectMinTempPerDay(daySaturday)
                            daySaturday[0].maxTemp = self.dayForecast.detectMaxTempPerDay(daySaturday)
                            
                            self.daysWeak.append(daySaturday[0])
                        }
                    }
                }
                if let city = dict["city"] as? Dictionary<String,Any>{
                    if let name = city["name"] as? String{
                        self.navigationItem.title = name
                    }
                }
                self.tableView.reloadData()
                
            }
            completed()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return daysWeak.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "daysId", for: indexPath) as? DaysForecastTableViewCell {
            
            var nameWeakAndIndex = [String:Int]()
            
            var dateComponents = DateComponents()
            dateComponents.setValue(1, for: .day);
            var now = Date()
            
            for index in 0...5 {
                
                let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)
                
                let detectDayIndex = index
                
                nameWeakAndIndex = [now.Days():detectDayIndex]
                
                now = tomorrow!
                
                daysWeak.sort(by: { (nameWeakAndIndex[$0.dayOfTheWeak] ?? 6) > (nameWeakAndIndex[$1.dayOfTheWeak] ?? 6) })
            }
            
            
            let day = daysWeak[indexPath.row]
            cell.configureCell(daysForecast: day)
            return cell
            
        }else{
            return DaysForecastTableViewCell()
        }
    }
    
    
    /// to update the days once the settiings get changed
    func updateDaysTVAfterChangeSettings(){
        daysWeak.removeAll()
        dayForecasts.removeAll()
        if daysWeak.count == 0 && dayForecasts.count == 0{ print("updated successfully") }
    }
    
    /// to update the view when the refresh button is clicked
    ///
    /// - Parameter sender: event generated button
    @IBAction func updateForecastInDaysTVController(_ sender: Any) {
        MSAnalytics.trackEvent("Day Forecast Refresh")
        daysWeak.removeAll()
        dayForecasts.removeAll()
        tableView.reloadData()
        viewDidAppear(true)
    }


}
