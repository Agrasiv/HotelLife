//
//  APIService.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 18/4/22.
//

import Foundation
import Alamofire

class APIService {
    
    static func getHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers["accept"] = "application/json"
        headers["x-rapidapi-key"] = "0b98c9866cmsh671c6c558820cc5p19e9c5jsnbbd691d32162"
        headers["X-RapidAPI-Host"] = "hotels-com-provider.p.rapidapi.com"
        return headers
    }
}
