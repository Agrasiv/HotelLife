//
//  MKMapView.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 6/4/22.
//

import Foundation
import MapKit

extension MKMapView {
    
    //MARK: Location Center
    func centertoLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
