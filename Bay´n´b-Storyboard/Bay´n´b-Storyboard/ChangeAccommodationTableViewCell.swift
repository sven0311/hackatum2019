//
//  ChangeAccommodationTableViewCell.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit

class ChangeAccommodationTableViewCell: UITableViewCell {
    
    var days = 0.0
    var accommodation: Accommodation? {
        didSet {
            updateView()
        }
    }
    
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var accImage: UIImageView!
    
    func updateView() {
        roomLabel.text = accommodation!.beds.description
        bedLabel.text = accommodation!.rooms.description
        priceLabel.text = (accommodation!.price * days).rounded(toPlaces: 2).description
        locationLabel.text = accommodation!.location
        accImage.image = accommodation!.image
    }
}
