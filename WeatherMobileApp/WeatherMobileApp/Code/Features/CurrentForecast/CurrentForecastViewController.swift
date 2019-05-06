//
//  ViewController.swift
//  WeatherMobileApp
//
//  Created by Prashanth on 04/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import UIKit
import CoreLocation
import AppCenterAnalytics

class CurrentForecastViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var sityTemperature: UILabel!
    @IBOutlet var imageWeather: UIImageView!
    @IBOutlet var descriptionWeather: UILabel!
    @IBOutlet var maxTemperature: UILabel!
    @IBOutlet var minTemperature: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var pressure: UILabel!
    
    @IBOutlet var visualTypeTemperatureCurrent: UILabel!
    @IBOutlet var visualTypeTemperatureMin: UILabel!
    @IBOutlet var visualTypeTemperatureMax: UILabel!
    
    @IBOutlet var visualTypeSpeed: UILabel!
    @IBOutlet var visualTypePressure: UILabel!
    
    
    var currentWeather: CurrentWeather!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currentWeather = CurrentWeather()
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
            currentWeather.downloadWeatherDetails {
                self.currentWeatherToday()
            }
            locationManager.stopUpdatingLocation()
        }else{
            print("non authorized")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        // Only called when variable have location data
        locationAuthStatus()
    }
    
    
    /// Update tle labels on Current weather to labels
    func currentWeatherToday(){
        self.navigationItem.title = currentWeather.sityName
        sityTemperature.text = "\(currentWeather.currentTemperature)"
        imageWeather.image = UIImage(named: currentWeather.imageWeather)
        descriptionWeather.text = currentWeather.weatherType
        
        animateWeather(currentWeather.weatherType)
        
        maxTemperature.text = "\(currentWeather.maxWeatherTemperature)"
        minTemperature.text = "\(currentWeather.minWeatherTemperature)"
        date.text = currentWeather.date
        windSpeed.text = "\(currentWeather.speed)"
        humidity.text = "\(currentWeather.humidity)"
        pressure.text = "\(currentWeather.pressure)"
        
        visualTypeTemperatureCurrent.text = globalValueTypeTemperature
        visualTypeTemperatureMin.text = globalValueTypeTemperature
        visualTypeTemperatureMax.text = globalValueTypeTemperature
        
        visualTypeSpeed.text = globalValueTypeWindSpeed
        visualTypePressure.text = globalValueTypePressure
    }
    
    
    /// to animate the screen based on the weather usin the emitterr
    ///
    /// - Parameter type: to determine the type
    func animateWeather(_ type: String){
        let emitter = Emitter.get(with: type)
        emitter.emitterPosition = CGPoint(x: view.frame.width/2, y: 0)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
        view.layer.addSublayer(emitter)
    }
    
    func reloadView() {
        self.viewDidLoad()
    }
    
    /// to update the view when the refresh button is clicked
    ///
    /// - Parameter sender: event generated button
    @IBAction func updateCurrentForecast(_ sender: Any){
        MSAnalytics.trackEvent("Current Status Refresh")
        self.viewDidLoad()
    }

}

