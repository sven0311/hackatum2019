//
//  Train.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation

class PublicTransport {
    
    var delegate: PublicTransportDelegate!
    
    var publicTransportPrice = 0.0
    var publicTransportStartPoint = ""
    var publicTransportEndPoint = ""
    var publicTransportDepartureTime = ""
    var publicTransportArrivalTime = ""
    var noPublicTransportAvailable = false
    
    
    init(cityStart: String, cityEnd: String, byTrain: Bool, delegate: PublicTransportDelegate) {
        self.delegate = delegate
        if byTrain {
            getTrain(cityStart: cityStart, cityEnd: cityEnd)
        } else {
            getPlane(cityStart: cityStart, cityEnd: cityEnd)
        }
    }
    
    init(price: Double, start: String, end: String, departure: String, arrival: String) {
        self.publicTransportPrice = price
        self.publicTransportStartPoint = start
        self.publicTransportEndPoint = end
        self.publicTransportDepartureTime = departure
        self.publicTransportArrivalTime = arrival
    }
    
    private func getPlane(cityStart: String, cityEnd: String) {
        let plane = plainList.min(by: compareTrains(train1:train2:))
        
        guard let plane1 = plane else {
            noPublicTransportAvailable = true
            return
        }
        
        self.publicTransportEndPoint = plane1.publicTransportEndPoint
        self.publicTransportStartPoint = plane1.publicTransportStartPoint
        self.publicTransportArrivalTime = plane1.publicTransportArrivalTime
        self.publicTransportDepartureTime = plane1.publicTransportDepartureTime
        self.publicTransportPrice = plane1.publicTransportPrice
    }
    
    private func getTrain(cityStart: String, cityEnd: String) {
        let train = trainList.min(by: compareTrains(train1:train2:))
        
        guard let train1 = train else {
            noPublicTransportAvailable = true
            return
        }
        
        self.publicTransportEndPoint = train1.publicTransportEndPoint
        self.publicTransportStartPoint = train1.publicTransportStartPoint
        self.publicTransportArrivalTime = train1.publicTransportArrivalTime
        self.publicTransportDepartureTime = train1.publicTransportDepartureTime
        self.publicTransportPrice = train1.publicTransportPrice
    }
    
    
    private func compareTrains(train1: PublicTransport, train2: PublicTransport) -> Bool {
        return train1.getScore() < train2.getScore()
    }
    
    private func getScore() -> Int {
        let times = publicTransportDepartureTime.split(separator: ":")
        let h = Int(times.first!)!
        return h.distance(to: 12) + Int(publicTransportPrice)
        
    }
}

protocol PublicTransportDelegate {
    func trainValuesDidChange()
}

private let trainList: [PublicTransport] = [
    PublicTransport(price: 23.00, start: "München HBF", end: "Garmisch-Partenkrichen BHF", departure: "8:30", arrival: "9:45"),
    PublicTransport(price: 39.99, start: "München HBF", end: "Garmisch-Partenkrichen BHF", departure: "14:30", arrival: "16:45"),
    PublicTransport(price: 80.00, start: "München HBF", end: "Garmisch-Partenkrichen BHF", departure: "18:30", arrival: "19:35"),
    PublicTransport(price: 20.34, start: "München HBF", end: "Garmisch-Partenkrichen BHF", departure: "4:30", arrival: "6:15"),
    PublicTransport(price: 34.15, start: "München HBF", end: "Garmisch-Partenkrichen BHF", departure: "10:30", arrival: "11:45")
]

private let plainList: [PublicTransport] = []
