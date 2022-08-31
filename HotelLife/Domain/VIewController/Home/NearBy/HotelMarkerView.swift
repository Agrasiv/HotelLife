//
//  HotelMarkerView.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 25/4/22.
//

import Foundation
import MapKit

class HotelMarkerView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
//            let hotels = newValue as? RestultResponseData
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
//            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
//            rightCalloutAccessoryView = mapsButton
            image = UIImage(named: "ic_pin")
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = "Example"
            detailCalloutAccessoryView = detailLabel
        }
    }
}
