//
//  AlamofireService.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 18/4/22.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

typealias ApiResultGet<T: Mappable> = (_ response: T?, _ error: Error?) -> ()

class AlamofireService {
    
    static let shared = AlamofireService()
    
    private init() {}
    
    func request<T: BaseResponse>(_ type: T.Type, at route: String, headers: HTTPHeaders, method: HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping ApiResultGet<T>) {
        let url = route
        
        debugPrint("url: ", url)
        debugPrint("headers: ", headers)
        
        Alamofire.request(url, method: method, encoding: encoding, headers: headers).validate().responseObject { (response: DataResponse<T>) in
            switch response.result {
            case .success(let response):
                if let result = Mapper<T>().map(JSONObject: response.toJSON()) {
                    if let finalErrors = result.errors {
                        for finalError in finalErrors {
                            completion(nil, APIError(type: finalError.type!, message: finalError.msg!))
                        }
                    } else {
                        completion(result, nil)
                    }
                } else {
                    completion(nil, APIError(type: "-1", message: Constants.ErrorMessage.unknown_error))
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
