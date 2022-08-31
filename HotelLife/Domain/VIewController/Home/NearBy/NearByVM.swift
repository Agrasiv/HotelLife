//
//  NearByVM.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 19/4/22.
//

import Foundation

protocol NearByVMPProtocol{
    
    func loadNearByHotel(latitude: Double, longitude: Double, currency: String, checkin_date: String, checkout_date: String, sort_order: String, adults_number: Int, locale: String) 
}

class NearByVM : BaseVM, NearByVMPProtocol {
    
    var queryData : ((QueryResponseData) -> Void)?
    var searchResultData : ((SearchResultResponseData) -> Void)?
    var pointOfSaleData : ((PointOfSaleResponseData) -> Void)?
    
    func loadNearByHotel(latitude: Double, longitude: Double, currency: String, checkin_date: String, checkout_date: String, sort_order: String, adults_number: Int, locale: String) {
        loading?(true)
        NearByDAO.shared.getNearByHotel(latitude: latitude, longitude: longitude, currency: currency, checkin_date: checkin_date, checkout_date: checkout_date, sort_order: sort_order, adults_number: adults_number, locale: locale) { [weak self] (response, error) in
            guard let self = self else {return}
            self.loading?(false)
            if let error = error {
                self.error?(error.localizedDescription)
                return
            }
            if let dataQuery = response?.query {
                self.queryData?(dataQuery)
            } else {
                self.error?(Constants.ErrorMessage.no_data_response)
            }
            if let dataSearchResult = response?.searchResults {
                self.searchResultData?(dataSearchResult)
            } else {
                self.error?(Constants.ErrorMessage.no_data_response)
            }
            if let dataPointOfSale = response?.pointOfSale {
                self.pointOfSaleData?(dataPointOfSale)
            } else {
                self.error?(Constants.ErrorMessage.no_data_response)
            }
        }
    }
    
    
}
