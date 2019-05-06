//
//  HourlyForecastTableViewCell.swift
//  WeatherMobileApp
//
//  Created by Prashanth on 06/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import UIKit

class HourlyForecastTableViewCell: UITableViewCell {
    
    @IBOutlet var hourlyTimePeriod: UILabel!
    @IBOutlet var hourlyImageForecast: UIImageView!
    @IBOutlet var hourlyTypeWeather: UILabel!
    @IBOutlet var hourlyForecastTemp: UILabel!
    @IBOutlet var hourlutWeatherDegrees: UILabel!
    
    func configureCell(hourlyForecast: HourlyForecast){
        hourlyTimePeriod.text = hourlyForecast.hourlyTimePeriod
        hourlyImageForecast.image = UIImage(named: hourlyForecast.hourlyImageForecast)
        hourlyTypeWeather.text = hourlyForecast.hourlyTypeWeather
        hourlyForecastTemp.text = "\(hourlyForecast.hourlyForecastTemp)"
        hourlutWeatherDegrees.text = hourlyForecast.hourlyForecastDegree
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
