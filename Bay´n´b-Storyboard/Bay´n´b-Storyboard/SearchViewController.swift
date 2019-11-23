//
//  SearchViewController.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 22.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var whatTextField: DesignableTextField!
    @IBOutlet weak var whereTextField: DesignableTextField!
    @IBOutlet weak var fromTextField: DesignableTextField!
    @IBOutlet weak var toTextField: DesignableTextField!
    @IBOutlet weak var bySegmentControl: UISegmentedControl!
    @IBOutlet weak var fromTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var byTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var planTripTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var planTripButton: UIButton!
    @IBOutlet weak var dateDividerLabel: UILabel!
    @IBOutlet weak var whereTopConstraint: NSLayoutConstraint!
    private var activityPicker = UIPickerView()
    var pickerData = ["", "Skiing", "Hiking", "Sightseeing"]
    
    private var fromDate = UIDatePicker()
    private var toDate = UIDatePicker()
    
    private var didAddLine = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tap)
        
        activityPicker.dataSource = self
        activityPicker.delegate = self
        
        whatTextField.delegate = self
        whatTextField.showCursor = false
        whatTextField.inputView = activityPicker
        
        whereTextField.alpha = 0.0
        whereTextField.addTarget(self, action: #selector(handleTextFieldTextChanged(_:)), for: .editingChanged)
        
        fromTextField.alpha = 0.0
        fromTextField.showCursor = false
        fromTextField.inputView = fromDate
        fromDate.addTarget(self, action: #selector(handleFromDatePicker), for: .valueChanged)
        fromDate.datePickerMode = .date
        
        toTextField.alpha = 0.0
        toTextField.showCursor = false
        toTextField.inputView = toDate
        toDate.addTarget(self, action: #selector(handleToDatePicker(_:)), for: .valueChanged)
        toDate.datePickerMode = .date
        
        dateDividerLabel.alpha = 0.0
        
        bySegmentControl.alpha = 0.0
        
        planTripButton.alpha = 0.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (didAddLine) {
            return
        }
        
        didAddLine = true
        
        whatTextField.addUnderline()
        whereTextField.addUnderline()
        fromTextField.addUnderline()
        toTextField.addUnderline()
    }
    
    func showTextField(_ textField: UIView, _ constraint: NSLayoutConstraint) {
        constraint.constant = 45
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            textField.alpha = 1.0
        })
    }
    
    func hideTextField(_ textField: UIView, _ constraint: NSLayoutConstraint) {
        constraint.constant = 80
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            textField.alpha = 0.0
        })
    }
    
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
            
            vC.accommodationBeds = 2 //TODO
            vC.activityString = "Skiing" //TODO
            vC.days = Double(toDate.date.offsetFrom(date: fromDate.date)) + 1.0
            vC.fromDate = fromDate.date
            vC.toDate = toDate.date
        }
        self.present(vC, animated: true, completion: nil)
        
    }
    
    @objc func hideKeyboard(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func handleFromDatePicker(_ datePicker: UIDatePicker) {
        fromTextField.text = datePicker.date.formatted
        toDate.minimumDate = fromDate.date
        UIView.animate(withDuration: 0.5, animations: {
            self.toTextField.alpha = 1.0
            self.dateDividerLabel.alpha = 1.0
        })
    }
    
    @objc func handleToDatePicker(_ datePicker: UIDatePicker) {
        toTextField.text = datePicker.date.formatted
        
        showTextField(bySegmentControl, byTopConstraint)
        showTextField(planTripButton, planTripTopConstraint)
    }
    
    @objc func handleTextFieldTextChanged(_ textField: UITextField) {
        switch textField {
        case whereTextField:
            if whereTextField.text?.isEmpty ?? true {
                hideTextField(fromTextField, fromTopConstraint)
                UIView.animate(withDuration: 0.5, animations: {
                    self.toTextField.alpha = 0.0
                    self.dateDividerLabel.alpha = 0.0
                })
            } else {
                showTextField(fromTextField, fromTopConstraint)
            }
        default:
            break
        }
    }
}
extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        whatTextField.text = pickerData[row]
        
        if (whatTextField.text?.isEmpty ?? true) {
            hideTextField(whereTextField, whereTopConstraint)
        } else {
            showTextField(whereTextField, whereTopConstraint)
        }
    }
}
extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField != whatTextField
    }
    
    
}
extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    var formatted: String {
        return Date.formatter.string(from: self)
    }
}

extension Date {

    func offsetFrom(date : Date) -> Int {

        let dayHourMinuteSecond: Set<Calendar.Component> = [.day]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self);

        return difference.day!
    }

}
