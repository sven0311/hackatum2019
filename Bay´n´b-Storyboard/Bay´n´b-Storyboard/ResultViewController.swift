//
//  ResultViewController.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit
import MapKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var publicTransportView: UIView!
    @IBOutlet weak var publicTransportPrice: UILabel!
    @IBOutlet weak var publicTransportStartPoint: UILabel!
    @IBOutlet weak var publicTransportEndPoint: UILabel!
    @IBOutlet weak var publicTransportDepartureTime: UILabel!
    @IBOutlet weak var publicTransportArrivalTime: UILabel!
    
    @IBOutlet weak var carView: UIView!
    @IBOutlet weak var carMap: MKMapView!
    @IBOutlet weak var carTime: UILabel!
    @IBOutlet weak var carDistance: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    
    @objc func editTransport(_ gesture: UITapGestureRecognizer) {
        print("edit transport")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(editTransport))
        carView.addGestureRecognizer(recognizer)
    }
}
