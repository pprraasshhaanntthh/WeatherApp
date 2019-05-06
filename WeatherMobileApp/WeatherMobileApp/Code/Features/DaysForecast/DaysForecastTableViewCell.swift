//
//  DaysForecastTableViewCell.swift
//  WeatherMobileApp
//
//  Created by Prashanth on 06/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import UIKit

class DaysForecastTableViewCell: UITableViewCell {
    
    /// day label to show the text for the week of this day
    @IBOutlet var day: UILabel!
    @IBOutlet var imageWeather: UIImageView!
    @IBOutlet var typeWeather: UILabel!
    @IBOutlet var minTemp: UILabel!
    @IBOutlet var maxTemp: UILabel!
    @IBOutlet var typeDegreeMax: UILabel!
    @IBOutlet var tupeDegreeMin: UILabel!
    

    /// to cconfigure/ mapping the cell content with DaysForecast object
    ///
    /// - Parameter daysForecast: contains details for the forecast
    func configureCell(daysForecast:DaysForecast){
        day.text = daysForecast.dayOfTheWeak
        imageWeather.image = UIImage(named: daysForecast.imageWeather)
        typeWeather.text = daysForecast.typeWeather
        minTemp.text = "\(daysForecast.minTemp)"
        maxTemp.text = "\(daysForecast.maxTemp)"
        typeDegreeMax.text = daysForecast.typeDegree
        tupeDegreeMin.text = daysForecast.typeDegree
    }
}
