//
//  NearBy.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 29/3/22.
//

import Foundation
import UIKit
import MapKit

class NearBy : BaseVC, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var checkinDatePicker: UIDatePicker!
    @IBOutlet weak var checkoutDatePicker: UIDatePicker!
    var locationManager : CLLocationManager!
    
    let vm = NearByVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(HotelMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        determineCurrentLocation()
        initBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: CLLocationManager Methods/ User current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(mRegion, animated: true)
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
    
    //MARK: Instance Methods
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func clickSearch(_ sender: Any) {
        vm.loadNearByHotel(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude, currency: "USD", checkin_date: dateString(datepicker: checkinDatePicker.date), checkout_date: dateString(datepicker: checkoutDatePicker.date), sort_order: "BEST_SELLER", adults_number: 1, locale: "en_US")
    }
    
    fileprivate func initBindings() {
        vm.error = { [weak self] errMsg in
            self?.showError(title: "Error", msg: errMsg, okbtnText: "OK")
        }
        vm.searchResultData = { [self] datas in
            let results = datas.results
            for hotelData in results {
                
                let annotation = MKPointAnnotation()
                annotation.title = hotelData.name
                annotation.coordinate = CLLocationCoordinate2D(latitude: hotelData.coordinate!.lat, longitude: hotelData.coordinate!.lon)
                annotation.subtitle = hotelData.address?.streetAddress
                mapView.addAnnotation(annotation)
            }
        }
    }
}

extension NearBy {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl
    ) {
        let hotels = hotels
        for hotelData in hotels {
            print(hotelData.title)
        }
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        hotels?.mapItem?.openInMaps(launchOptions: launchOptions)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? RestultResponseData else { return nil }
//        let identifier = "artwork"
//        var view: MKMarkerAnnotationView
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(
//          withIdentifier: identifier) as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation as? MKAnnotation
//          view = dequeuedView
//        } else {
//          view = MKMarkerAnnotationView(
//            annotation: annotation as? MKAnnotation,
//            reuseIdentifier: identifier)
//          view.canShowCallout = true
//          view.calloutOffset = CGPoint(x: -5, y: 5)
//          view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//      }
}



