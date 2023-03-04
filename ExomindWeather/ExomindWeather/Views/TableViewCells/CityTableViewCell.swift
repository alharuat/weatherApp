//
//  CityTableViewCell.swift
//  ExomindWeather
//
//  Created by Samir on 4/3/23.
//

import UIKit
import Lottie
class CityTableViewCell: UITableViewCell {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var animationView: LottieAnimationView!
    var lat, lon: Double!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
