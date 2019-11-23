//
//  Activity.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation

class Activity {
    
    var delegate: ActivityDelegate?
    
    var activity = ""
    var price = 0.0
    
    init(activity: String, delegate: ActivityDelegate) {
        getActivities(activity: activity)
    }
    
    init(activity: String, price: Double) {
        self.activity = activity
        self.price = price
    }
    
    func getActivities(activity: String) {
        let act = getActivitiesList(activity: activity).min(by: compareActivities(act1:act2:))
        
        guard let act1 = act else {
            print("No activity found")
            return
        }
        
        self.activity = act1.activity
        self.price = act1.price
    }
    
    private func compareActivities(act1: Activity, act2: Activity) -> Bool{
        return act1.price < act2.price
    }
    
    func getActivitiesList(activity: String) -> [Activity]{
        //TODO Activity API call
        
        return mockActivities
    }
}

protocol ActivityDelegate {
    func activityValuesDidChange()
}

var mockActivities: [Activity] = [
    Activity(activity: "Ski Amade Zugspize", price: 44.0),
    Activity(activity: "Ski Garmisch", price: 42.5)
]
