//
//  LocalStorage.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 28/3/22.
//

import Foundation
import ObjectMapper
import FirebaseAuth

struct UserDefaultKey {
    static let userLoginModel = "userLoginModel"
}

class LocalStorage {
    
    static let shared = LocalStorage()
    let defaults = UserDefaults.standard
    
    private init() {}
    
//    func saveLoginModel(email: String) {
//        defaults.set(email, forKey: UserDefaultKey.userLoginModel)
//        defaults.synchronize()
//    }
    
}
