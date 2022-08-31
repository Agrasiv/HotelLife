//
//  Constant.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 4/4/22.
//

import Foundation

struct Constants {
    struct API {
        static let imageURL = "https://firebasestorage.googleapis.com/v0/b/hotellife-5455c.appspot.com/o/ProfileImage%2F"
        static let apiURL = "https://hotels-com-provider.p.rapidapi.com/v1/"
    }
    
    struct Route {
        //NearBy
        static let NearBy = "hotels/nearby"
    }
    
    struct ErrorMessage {
        static let unknown_error = "unknown_error"
        static let no_data_response = "no_data_response"
    }
}


