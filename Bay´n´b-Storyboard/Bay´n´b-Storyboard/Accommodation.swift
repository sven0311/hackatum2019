//
//  Accommodation.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation
import UIKit

class Accommodation {
    
    var delegate: AccommodationDelegate?
    
    public var beds = 0
    public var rooms = 0
    public var price = 0.0
    public var location = ""
    public var image: UIImage?
    public var fromDate = Date()
    public var toDate = Date() + 150000
    
    init(bed: Int, location: String, fromDate: Date, toDate: Date, delegate: AccommodationDelegate) {
        self.delegate = delegate
        self.fromDate = fromDate
        self.toDate = toDate
        getAccommodation(bed: bed, location: location)
    }
    
    init(beds: Int, rooms: Int, price: Double, location: String, image: UIImage?) {
        self.beds = beds
        self.rooms = rooms
        self.price = price
        self.location = location
        self.image = image
    }
    
    private func getAccommodation(bed: Int, location: String) {
        let acc = getAccommodationList(bed: bed, location: location).min(by: compareAccomodations(acc1:acc2:))
        
        guard let acc1 = acc else {
            print("No accommodations found")
            return
        }
        
        self.beds = acc1.beds
        self.location = acc1.location
        self.rooms = acc1.rooms
        self.image = acc1.image
        self.price = acc1.price
    }
    
    private func compareAccomodations(acc1: Accommodation, acc2: Accommodation) -> Bool{
        return acc1.price < acc2.price
    }
    
    private func getAccommodationList(bed: Int, location: String) -> [Accommodation] {
        //TODO Activity API call
        
        return mockAccommodations
    }
    
}

protocol AccommodationDelegate {
    func accommodationValuesDidChange()
}


private var mockAccommodations: [Accommodation] = [
    Accommodation(beds: 2, rooms: 1, price: 89, location: "Garmisch-Partenkirchen - Hauptstraße 4", image: UIImage(named: "huette1")),
    Accommodation(beds: 4, rooms: 2, price: 140, location: "Garmisch-Partenkirchen - Dorfstraße 34", image: UIImage(named: "huette2")),
    Accommodation(beds: 3, rooms: 1, price: 99, location: "Garmisch-Partenkirchen - Reichsweg 56b", image: UIImage(named: "huette3")),
    Accommodation(beds: 2, rooms: 1, price: 120, location: "Garmisch-Partenkirchen - Könignsalle 23", image: UIImage(named: "huette4"))
]
