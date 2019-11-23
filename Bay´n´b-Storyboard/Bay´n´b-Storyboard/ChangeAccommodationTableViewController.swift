//
//  ChangeAccommodationTableViewController.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit

class ChangeAccommodationTableViewController : UITableViewController {
    
    var accommodations: [Accommodation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        .dataSource = self

    }
}

extension ChangeAccommodationTableViewController: UITableViewDataSource {

}


