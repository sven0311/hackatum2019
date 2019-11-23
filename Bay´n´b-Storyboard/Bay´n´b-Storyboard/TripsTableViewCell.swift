//
//  TripsTableViewCell.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit

class TripsTableViewCell: UITableViewCell {
    
    var trip: (PublicTransport?, Car?, Accommodation, Activity)? {
        didSet {
            updateView()
        }
    }
    
    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var tripWhereLabel: UILabel!
    @IBOutlet weak var tripWhenLabel: UILabel!
    @IBOutlet weak var tripActionImage: UIImageView!
    
    func updateView() {
        tripWhereLabel.text = trip?.2.location
        
        let format = DateFormatter()
        format.dateFormat = "dd.MM.yyyy"
        let formattedFromDate = format.string(from: trip!.2.fromDate)
        let formattedToDate = format.string(from: trip!.2.toDate)

        
        tripWhenLabel.text = formattedFromDate + " - " + formattedToDate
        tripImage.image = trip?.2.image
        
        tripActionImage.image = UIImage(named: "icons8-skiing-100")
    }
    
}
