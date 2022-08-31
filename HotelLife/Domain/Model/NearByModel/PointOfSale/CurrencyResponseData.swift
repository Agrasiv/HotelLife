//
//  CurrencyResponseData.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 19/4/22.
//

import Foundation
import ObjectMapper

class CurrencyResponseData : Mappable {
    
    var code : String?
    var symbol : String?
    var separators : String?
    var format : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        code                  <- map["code"]
        symbol                <- map["symbol"]
        separators          <- map["separators"]
        format             <- map["format"]
    }
}
