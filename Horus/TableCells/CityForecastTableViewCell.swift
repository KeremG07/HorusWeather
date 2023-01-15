//
//  CityForecastTableViewCell.swift
//  Horus
//
//  Created by Kerem Girenes on 15.01.2023.
//

import UIKit

class CityForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
