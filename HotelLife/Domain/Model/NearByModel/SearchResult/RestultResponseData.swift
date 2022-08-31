//
//  RestultResponseData.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 18/4/22.
//

import Foundation
import ObjectMapper
import Contacts
import MapKit

class RestultResponseData : NSObject, MKAnnotation, Mappable {
    
    var coordinate: CLLocationCoordinate2D
    var id : Int = 0
    var name : String?
    var starRating : Int = 0
    var address : AddressResponseData?
    var guestReviews : GustReviewResponseData?
    var landmarks : [LandMarkResponseData]?
    var ratePlan : RatePlanResponseData?
    var neighbourhood : String?
    var coordinates : CoordinateResponseData?
    var providerType : String?
    var supplierHotelId : Int = 0
    var optimizedThumbUrls : OptimizedThumbUrlsResponseData?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        starRating          <- map["starRating"]
        address             <- map["address"]
        guestReviews        <- map["guestReviews"]
        landmarks           <- map["landmarks"]
        ratePlan            <- map["ratePlan"]
        neighbourhood       <- map["neighbourhood"]
        coordinate          <- map["coordinate"]
        providerType        <- map["providerType"]
        supplierHotelId     <- map["supplierHotelId"]
        optimizedThumbUrls  <- map["optimizedThumbUrls"]
    }
    
    var mapItem: MKMapItem? {
        let locationString : String? =  address!.streetAddress! + address!.extendedAddress! + address!.locality! + address!.countryName!
        guard let location = locationString  else { return nil }
        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: coordinates!.lat, longitude: coordinates!.lon),
                                    addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        return mapItem
    }
}

class AddressResponseData : Mappable {
    
    var streetAddress : String?
    var extendedAddress : String?
    var locality : String?
    var postalCode : String?
    var region : String?
    var countryName : String?
    var countryCode : String?
    var obfuscate : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        streetAddress                  <- map["streetAddress"]
        extendedAddress                <- map["extendedAddress"]
        locality                       <- map["locality"]
        postalCode                     <- map["postalCode"]
        region                         <- map["region"]
        countryName                    <- map["countryName"]
        countryCode                    <- map["countryCode"]
        obfuscate                      <- map["obfuscate"]
    }
}

class GustReviewResponseData : Mappable {
    
    var unformattedRating : Int = 0
    var rating : String?
    var total : Int = 0
    var scale : Int = 0
    var badge : String?
    var badgeText : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        unformattedRating     <- map["unformattedRating"]
        rating                <- map["rating"]
        total                 <- map["total"]
        scale                 <- map["scale"]
        badge                 <- map["badge"]
        badgeText             <- map["badgeText"]
    }
}

class LandMarkResponseData : Mappable {
    
    var distance : String?
    var label : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        distance       <- map["distance"]
        label          <- map["label"]
    }
}

class RatePlanResponseData : Mappable {
    
    var price : PriceResponseData?
    var features : FeaturesResponseData?
    var type : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        price             <- map["price"]
        features          <- map["features"]
        type              <- map["type"]
    }
    
    
}

class CoordinateResponseData : Mappable {
    
    var lat : Double = 0.0
    var lon : Double = 0.0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        lat             <- map["lat"]
        lon             <- map["lon"]
    }
}

class OptimizedThumbUrlsResponseData : Mappable {
    
    var srpDesktop : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        srpDesktop      <- map["srpDesktop"]
    }
    
    
}

class PriceResponseData : Mappable {
    
    var current : String?
    var exactCurrent : Double = 0.0
    var fullyBundledPricePerStay : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        current                      <- map["current"]
        exactCurrent                 <- map["exactCurrent"]
        fullyBundledPricePerStay     <- map["fullyBundledPricePerStay"]
    }
}

class FeaturesResponseData : Mappable {
    
    var freeCancellation : Bool?
    var paymentPreference : Bool?
    var noCCRequired : Bool?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        freeCancellation             <- map["freeCancellation"]
        paymentPreference            <- map["paymentPreference"]
        noCCRequired                 <- map["noCCRequired"]
    }
}
