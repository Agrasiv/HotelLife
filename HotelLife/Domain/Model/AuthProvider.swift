//
//  AuthProvider.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 30/3/22.
//

import Foundation

enum AuthProvider : String {
    
    case google = "google.com"
    case facebook = "facebook.com"
    case emailPassword = "password"
    case twitter = "twitter.com"
    
    init?(rawValue: String) {
      switch rawValue {
      case "google.com":
        self = .google
      case "twitter.com":
        self = .twitter
      case "facebook.com":
        self = .facebook
      case "password":
        self = .emailPassword
      default: return nil
      }
    }
}
