//
//  ChangeAccommodationTableViewController.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit

class ChangeAccommodationTableViewController : UITableViewController {
    
    var resDelegate: EditAccommodation?
    var accommodations: [Accommodation]?
    var days = 0.0
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resDelegate?.updateAccommodation(acc: accommodations![indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accommodations!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let table = tableView.dequeueReusableCell(withIdentifier: "accommodationChangeCell")
        let accTable = table as! ChangeAccommodationTableViewCell
        
        accTable.accommodation = accommodations![indexPath.row]
        accTable.days = days
        return accTable
    }
}

protocol EditAccommodation {
    func updateAccommodation(acc: Accommodation)
}

