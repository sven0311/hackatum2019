//
//  SearchViewController.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 22.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var whatTextField: UITextField!
    @IBOutlet weak var whereTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var bySegmentControl: UISegmentedControl!
    
    private var fromDate = UIDatePicker()
    private var toDate = UIDatePicker()
    
    @IBAction func search(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vC = storyboard.instantiateViewController(identifier: "Result")
        if let vC = vC as? ResultViewController {
            let transport = bySegmentControl.selectedSegmentIndex
            if (transport == 0) { //car
                vC.byCar = true
                vC.addressTo = "Garmisch-Partenkirchen" //TODO
                vC.addressFrom = "München" //TODO
            }
            if (transport == 1) { //train
                vC.byTrain = true
            }
            if (transport == 2) { //plane
                vC.byPlane = true
            }
        }
        self.present(vC, animated: true, completion: nil)
        
    }
    
    @objc func handleFromDatePicker(_ datePicker: UIDatePicker) {
        fromTextField.text = datePicker.date.formatted
    }
    
    @objc func handleToDatePicker(_ datePicker: UIDatePicker) {
        toTextField.text = datePicker.date.formatted
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromTextField.inputView = fromDate
        toTextField.inputView = toDate
        
        fromDate.addTarget(self, action: #selector(handleFromDatePicker), for: .valueChanged)
        toDate.addTarget(self, action: #selector(handleToDatePicker), for: .valueChanged)
        
    }
}

extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM yyyy"
        return formatter
    }()
    var formatted: String {
        return Date.formatter.string(from: self)
    }
}

