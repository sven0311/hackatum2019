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
    
    var addressFrom = ""
    var addressTo = ""
    var byCar = false
    var byTrain = false
    var byPlane = false
    var car: Car?
    var publicTransport: PublicTransport?
    var accommodation: Accommodation?
    var accommodationBeds = 0
    
    @IBOutlet weak var publicTransportView: UIView!
    @IBOutlet weak var publicTransportPrice: UILabel!
    @IBOutlet weak var publicTransportStartPoint: UILabel!
    @IBOutlet weak var publicTransportEndPoint: UILabel!
    @IBOutlet weak var publicTransportDepartureTime: UILabel!
    @IBOutlet weak var publicTransportArrivalTime: UILabel!
    @IBOutlet weak var publicTransportLabel: UILabel!
    @IBOutlet weak var noPublicTransportLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var startPointLabel: UILabel!
    @IBOutlet weak var endPointLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    @IBOutlet weak var carView: UIView!
    @IBOutlet weak var carMap: MKMapView!
    @IBOutlet weak var carTime: UILabel!
    @IBOutlet weak var carDistance: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    
    @IBOutlet weak var accommodationView: UIView!
    @IBOutlet weak var accomodationRooms: UILabel!
    @IBOutlet weak var accommodationBed: UILabel!
    @IBOutlet weak var accommodationPrice: UILabel!
    @IBOutlet weak var accommodationImage: UIImageView!
    @IBOutlet weak var accommodationLocation: UILabel!
    
    @objc func editTransport(_ gesture: UITapGestureRecognizer) {
        print("edit transport")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(editTransport))
        
        if byCar {
            publicTransportView.isHidden = true
            
            carView.addGestureRecognizer(recognizer)
            
            car = Car(addressFrom: addressFrom, addressTo: addressTo)
            car!.delegate = self
        }
        
        if byTrain || byPlane {
            carView.isHidden = true
            
            
            publicTransportView.addGestureRecognizer(recognizer)
            
            if (byTrain) {
                publicTransport = PublicTransport(cityStart: addressFrom, cityEnd: addressTo, byTrain: true, delegate: self)
                trainValuesDidChange()
            }
            if (byPlane) {
                publicTransport = PublicTransport(cityStart: addressFrom, cityEnd: addressTo, byTrain: false, delegate: self)
                trainValuesDidChange()
            }
        }
    

        accommodation = Accommodation(bed: accommodationBeds, location: addressTo, delegate: self)
        accommodationValuesDidChange()
        
        
    }
}
extension ResultViewController: CarDelegate {
    func carValuesDidChange() {
        carMap.addOverlay((car!.route.polyline), level: MKOverlayLevel.aboveRoads)
        
        let rect = car!.route.polyline.boundingMapRect
        self.carMap.setRegion(MKCoordinateRegion(rect), animated: true)
        carTime.text = (car!.time.rounded(toPlaces: 0)/3600).rounded(toPlaces: 1).description + " h"
        carDistance.text = car!.distance.rounded(toPlaces: 1).description + " km"
        carPrice.text = car!.price.rounded(toPlaces: 2).description + " €"
    }
}

extension ResultViewController: AccommodationDelegate {
    func accommodationValuesDidChange() {
        accommodationBed.text = accommodation!.beds.description
        accomodationRooms.text = accommodation?.rooms.description
        accommodationPrice.text = accommodation!.price.rounded(toPlaces: 2).description + " €"
        accommodationLocation.text = accommodation!.location.description
        accommodationImage.image = accommodation?.image
    }
}

extension ResultViewController: PublicTransportDelegate {
    func trainValuesDidChange() {
        if (publicTransport!.noPublicTransportAvailable) {
            noPublicTransportLabel.isHidden = false
            publicTransportArrivalTime.isHidden = true
            publicTransportStartPoint.isHidden = true
            publicTransportEndPoint.isHidden = true
            publicTransportDepartureTime.isHidden = true
            publicTransportPrice.isHidden = true
            
            priceLabel.isHidden = true
            departureTimeLabel.isHidden = true
            endPointLabel.isHidden = true
            startPointLabel.isHidden = true
            arrivalTimeLabel.isHidden = true
            publicTransportLabel.isHidden = true

            return
        }
        
        publicTransportPrice.text = publicTransport!.publicTransportPrice.description
        publicTransportEndPoint.text = publicTransport!.publicTransportEndPoint
        publicTransportStartPoint.text = publicTransport!.publicTransportStartPoint
        publicTransportArrivalTime.text = publicTransport!.publicTransportArrivalTime
        publicTransportDepartureTime.text = publicTransport!.publicTransportDepartureTime
    }
}

extension ResultViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 4.0
    
        return renderer
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
