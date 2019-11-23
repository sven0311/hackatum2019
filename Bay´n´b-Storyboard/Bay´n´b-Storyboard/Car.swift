//
//  Car.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Car {
    
    var delegate: CarDelegate!
    
    var price: Double
    var distance: Double
    var time: TimeInterval
    var route: MKRoute

    
    init(addressFrom: String, addressTo: String) {
        self.distance = 0.0
        self.time = TimeInterval()
        self.price = 0.0
        self.route = MKRoute()
        setDistanceAndPrizeAndTime(addressFrom: addressFrom, addressTo: addressTo)
    }
    
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(location)
        }
    }
    
    private func setDistanceAndPrizeAndTime(addressFrom: String, addressTo: String) {
        DispatchQueue.global().async {
            print("Draußen")
            DispatchQueue.main.sync {
                print("Drinnen")
                self.getLocation(from: addressFrom) { fromCoordinate in
                    guard let fromCoordinate = fromCoordinate else {
                        print("fromCoordination is shit")
                        return
                    }
                    print("locationFrom")
                    self.getLocation(from: addressTo) { toCoordinate in
                        guard let toCoordinate = toCoordinate else {
                            return
                        }
                        print(toCoordinate.latitude.description + " " + toCoordinate.longitude.description)
                        let source = MKPlacemark(coordinate: fromCoordinate)
                        let destination = MKPlacemark(coordinate: toCoordinate)
                        let request = MKDirections.Request()
                        request.source = MKMapItem(placemark: source)
                        request.destination = MKMapItem(placemark: destination)
                        
                        request.transportType = MKDirectionsTransportType.automobile;
                        
                        let directions = MKDirections(request: request)
                        
                        directions.calculate { (response, error) in
                            if let error = error {
                                print(error)
                                return
                            }
                            if let response = response, let route = response.routes.first {
                                self.route = route
                                self.distance = route.distance / 1000
                                self.time = route.expectedTravelTime
                                self.price = self.getPrize(for: self.distance)
                                self.delegate.carValuesDidChange()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getPrize(for distance: Double) -> Double {
        return distance * 0.3
    }
}

protocol CarDelegate {
    func carValuesDidChange()
}
