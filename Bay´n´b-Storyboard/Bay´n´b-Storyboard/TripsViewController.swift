//
//  TripsViewController.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController {
  
    static var trips: [(PublicTransport?, Car?, Accommodation, Activity)] = [] {
        didSet {
            viewController?.tripTableView?.reloadData()
        }
    }
    static var viewController: TripsViewController!

    @IBOutlet weak var tripTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TripsViewController.viewController = self
        
        tripTableView!.dataSource = self
        
        
    }
}

extension TripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TripsViewController.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let table = tableView.dequeueReusableCell(withIdentifier: "TripsViewCell")
        let tripsTable = table as! TripsTableViewCell
        
        tripsTable.trip = TripsViewController.trips[indexPath.row]
        return tripsTable
    }
    
    
}

