//
//  DestinationResponseData.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 18/4/22.
//

import Foundation
import ObjectMapper

class DestinationResponseData : Mappable {
    
    var id : String?
    var value : String?
    var resolvedLocation : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id                  <- map["id"]
        value               <- map["value"]
        resolvedLocation    <- map["resolvedLocation"]
    }
}
