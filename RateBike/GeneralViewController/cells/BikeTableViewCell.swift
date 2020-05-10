//
//  BikeTableViewCell.swift
//  RateBike
//
//  Created by Сергей Вихляев on 10.05.2020.
//  Copyright © 2020 Сергей Вихляев. All rights reserved.
//

import UIKit

class BikeTableViewCell: UITableViewCell {
    
    fileprivate let imageMyChoice = UIImage(systemName: "heart")
    
    @IBOutlet weak var bikeNameLabel: UILabel!
    @IBOutlet weak var bikeInfoLabel: UILabel!
    @IBOutlet weak var myChoiceImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func cofigure(withBike bike: Bike) {
        bikeNameLabel.text = bike.model
        bikeInfoLabel.text = bike.mark
        
        if bike.myCoice {
            myChoiceImageView.image = imageMyChoice
        } else {
            myChoiceImageView.image = nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bikeNameLabel.text = ""
        bikeInfoLabel.text = ""
        myChoiceImageView.image = nil
    }
}
