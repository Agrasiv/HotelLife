//
//  NearByDAO.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 18/4/22.
//

import Foundation

class NearByDAO {
    
    static let shared = NearByDAO()
    
    private init() {}
    
    func getNearByHotel(latitude: Double, longitude: Double, currency: String, checkin_date: String, checkout_date: String, sort_order: String, adults_number: Int, locale: String, completion: @escaping ApiResultGet<NearByModel>) {
        
        let header = APIService.getHeaders()
        
        AlamofireService.shared.request(NearByModel.self,
                                        at: Constants.API.apiURL + Constants.Route.NearBy + "?" +
                                        "latitude=" + "\(latitude)" + "&" +
                                        "longitude=" + "\(longitude)" + "&" +
                                        "currency=" + currency + "&" +
                                        "checkin_date=" + checkin_date + "&" +
                                        "checkout_date=" + checkout_date + "&" +
                                        "sort_order=" + sort_order + "&" +
                                        "adults_number=" + "\(adults_number)" + "&" +
                                        "locale=" + locale,
                                        headers: header,
                                        method: .get,
                                        completion: completion)
    }
}
