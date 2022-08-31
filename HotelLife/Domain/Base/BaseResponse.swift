//
//  BaseResponse.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 18/4/22.
//

import Foundation
import ObjectMapper

class BaseResponse : Mappable {
    
    var errors : [ErrorDetail]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        errors    <- map["detail"]
    }
}

class ErrorDetail : Mappable {
    
    var msg : String?
    var type : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        msg              <- map["msg"]
        type             <- map["type"]
    }
    
}


