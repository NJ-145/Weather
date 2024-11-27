//
//  TimeTableViewCell.swift
//  Weather
//
//  Created by imac-2626 on 2024/11/25.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet var lbTime: UILabel!
    
    @IBOutlet var lbWeatherImage: UIImageView!
    
    @IBOutlet var lbRain: UILabel!
    
    @IBOutlet var lbRainImage: UIImageView!
    
    @IBOutlet var lbWeather: UILabel!
    
    @IBOutlet var lbTemperatureIm: UIImageView!
    
    @IBOutlet var lbTemperature: UILabel!
    
    @IBOutlet var lbComfortIm: UIImageView!
    
    @IBOutlet var lbComfort: UILabel!
    
    
    static let identifier = "TimeTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
