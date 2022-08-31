//
//  APIErrorCode.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 18/4/22.
//

import Foundation

class APIError: LocalizedError {
    
    let type: String
    let message: String
    
    init(type: String, message: String) {
        self.type = type
        self.message = message
    }
    
    public var errorDescription: String? {
        message
    }
}
