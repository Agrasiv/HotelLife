//
//  NearByModel.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 18/4/22.
//

import Foundation
import ObjectMapper

class NearByModel : BaseResponse {
    
    var query : QueryResponseData?
    var searchResults : SearchResultResponseData?
    var pointOfSale : PointOfSaleResponseData?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        query            <- map["query"]
        searchResults    <- map["searchResults"]
        pointOfSale      <- map["pointOfSale"]
    }
}

class QueryResponseData : Mappable {
    
    var destination : DestinationResponseData?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        destination       <- map["destination"]
    }
}

class SearchResultResponseData : Mappable {
    
    var totalCount : Int = 0
    var results : [RestultResponseData] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        totalCount      <- map["totalCount"]
        results         <- map["results"]
    }
}


class PointOfSaleResponseData : Mappable {
    
    var currency : CurrencyResponseData?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        currency      <- map["currency"]
    }
}
