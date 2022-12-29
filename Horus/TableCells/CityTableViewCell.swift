//
//  CityTableViewCell.swift
//  Horus
//
//  Created by Kerem Girenes on 27.12.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var underlayingImageView: UIImageView!
    
    @IBOutlet weak var overlayingImageView: UIImageView!
    
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
