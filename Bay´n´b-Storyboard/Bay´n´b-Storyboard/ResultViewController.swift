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
    var activity: Activity?
    var activityString = ""
    var accommodationBeds = 0
    var totalPrice = 0.0 {
        didSet {
            bookButton.setTitle("Book now \(totalPrice)", for: .normal)
        }
    }
    var days = 0.0
    var fromDate = Date()
    var toDate = Date()
    
    @IBOutlet weak var publicTransportView: UIView!
    @IBOutlet weak var publicTransportPrice: UILabel!
    @IBOutlet weak var publicTransportStartPoint: UILabel!
    @IBOutlet weak var publicTransportEndPoint: UILabel!
    @IBOutlet weak var publicTransportDepartureTime: UILabel!
    @IBOutlet weak var publicTransportArrivalTime: UILabel!
    @IBOutlet weak var noPublicTransportLabel: UILabel!
    @IBOutlet weak var noPublicTransportConnectionLabel: UILabel!
    @IBOutlet weak var publicTransportIcon: UIImageView!
    @IBOutlet weak var pTStartPoint: UIImageView!
    @IBOutlet weak var pTEndPoint: UIImageView!
    @IBOutlet weak var pTDepartureTime: UIImageView!
    @IBOutlet weak var pTArrivalTime: UIImageView!
    @IBOutlet weak var pTPrice: UIImageView!
    
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
    
    @IBOutlet weak var accomodationTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var accommodationPTTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityPrice: UILabel!
    
    @IBOutlet weak var bookButton: UIButton!
    
    @IBAction func book(_ sender: Any) {
        TripsViewController.trips.append((publicTransport, car, accommodation!, activity!))
        let alert = UIAlertController(title: "Succesfully booked", message: "Your trip is added to your upcoming trips", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func editTransport(_ gesture: UITapGestureRecognizer) {
        print("edit transport")
    }
    
    @objc func editAccomodation(_ gesture: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vC = storyboard.instantiateViewController(identifier: "changeAccommodation")
        
        present(vC, animated: true, completion: nil)
    }
    
    @objc func editActivity(_ gesture: UITapGestureRecognizer) {
        print("edit activity")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let transportRecognizer = UITapGestureRecognizer(target: self, action: #selector(editTransport))
        
        if byCar {
            publicTransportView.isHidden = true
            carView.isHidden = false
            accommodationPTTopConstraint.isActive = false
            accomodationTopConstraint.isActive = true
            
            carView.addGestureRecognizer(transportRecognizer)
            
            car = Car(addressFrom: addressFrom, addressTo: addressTo)
            car!.delegate = self
            carMap.delegate = self
        }
        
        if byTrain || byPlane {
            carView.isHidden = true
            publicTransportView.isHidden = false
            accommodationPTTopConstraint.isActive = true
            accomodationTopConstraint.isActive = false
            
            publicTransportView.addGestureRecognizer(transportRecognizer)
            
            if (byTrain) {
                publicTransport = PublicTransport(cityStart: addressFrom, cityEnd: addressTo, byTrain: true, delegate: self)
                trainValuesDidChange()
                
                publicTransportIcon.image = UIImage(systemName: "tram.fill")
            }
            if (byPlane) {
                publicTransport = PublicTransport(cityStart: addressFrom, cityEnd: addressTo, byTrain: false, delegate: self)
                trainValuesDidChange()
                
                publicTransportIcon.image = UIImage(systemName: "airplane")
            }
        }
        
        let accomodationRecognizer = UITapGestureRecognizer(target: self, action: #selector(editAccomodation))
        accommodationView.addGestureRecognizer(accomodationRecognizer)

        accommodation = Accommodation(bed: accommodationBeds, location: addressTo, fromDate: fromDate, toDate: toDate, delegate: self)
        accommodationValuesDidChange()
        
//        let activityRecognizer = UITapGestureRecognizer(target: self, action: #selector(editActivity))
//        activityView.addGestureRecognizer(activityRecognizer)
        
        activity = Activity(activity: activityString, delegate: self)
        activityValuesDidChange()
        
        
        bookButton.setTitle("Book now \(totalPrice)", for: .normal)
    }
}
extension ResultViewController: CarDelegate {
    func carValuesDidChange() {
        
        carMap.addOverlay((car!.route.polyline))
        
        var rect = car!.route.polyline.boundingMapRect
        rect.origin.x -= 40000
        rect.origin.y -= 40000
        rect.size = MKMapSize(width: rect.width + 80000, height: rect.height + 80000)
        self.carMap.setRegion(MKCoordinateRegion(rect), animated: true)
        
        carTime.text = (car!.time.rounded(toPlaces: 0)/3600).rounded(toPlaces: 1).description + " h"
        carDistance.text = car!.distance.rounded(toPlaces: 1).description + " km"
        carPrice.text = car!.price.rounded(toPlaces: 2).description + " €"
        
        totalPrice += car!.price.rounded(toPlaces: 2)
    }
}

extension ResultViewController: ActivityDelegate {
    func activityValuesDidChange() {
        activityLabel.text = activity!.activity
        activityPrice.text = (days * activity!.price).rounded(toPlaces: 2).description + " €"
        
        totalPrice += (days * activity!.price).rounded(toPlaces: 2)

    }
}

extension ResultViewController: AccommodationDelegate {
    func accommodationValuesDidChange() {
        accommodationBed.text = accommodation!.beds.description
        accomodationRooms.text = accommodation?.rooms.description
        accommodationPrice.text = (days * accommodation!.price).rounded(toPlaces: 2).description + " €"
        accommodationLocation.text = accommodation!.location.description
        accommodationImage.image = accommodation?.image
        
        totalPrice += (days * accommodation!.price).rounded(toPlaces: 2)

    }
}

extension ResultViewController: PublicTransportDelegate {
    func trainValuesDidChange() {
        if (publicTransport!.noPublicTransportAvailable) {
            noPublicTransportLabel.isHidden = false
            noPublicTransportConnectionLabel.isHidden = false
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
            publicTransportIcon.isHidden = true
            
            pTStartPoint.isHidden = true
            pTEndPoint.isHidden = true
            pTDepartureTime.isHidden = true
            pTArrivalTime.isHidden = true
            pTPrice.isHidden = true

            return
        }
        
        publicTransportPrice.text = publicTransport!.publicTransportPrice.rounded(toPlaces: 2).description + " €"
        publicTransportEndPoint.text = publicTransport!.publicTransportEndPoint
        publicTransportStartPoint.text = publicTransport!.publicTransportStartPoint
        publicTransportArrivalTime.text = publicTransport!.publicTransportArrivalTime
        publicTransportDepartureTime.text = publicTransport!.publicTransportDepartureTime
        
        totalPrice += publicTransport!.publicTransportPrice.rounded(toPlaces: 2)

    }
}

extension ResultViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let polylineRenderer = MKPolylineRenderer(overlay: overlay)
    if (overlay is MKPolyline) {
      if mapView.overlays.count == 1 {
        polylineRenderer.strokeColor =
            UIColor.blue
      } else if mapView.overlays.count == 2 {
        polylineRenderer.strokeColor =
            UIColor.green
      } else if mapView.overlays.count == 3 {
        polylineRenderer.strokeColor =
          UIColor.red
      }
      polylineRenderer.lineWidth = 5
    }
    return polylineRenderer
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
