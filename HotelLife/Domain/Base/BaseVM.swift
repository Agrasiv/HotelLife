//
//  BaseVM.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 19/4/22.
//

import Foundation

class BaseVM {
    var loading: ((Bool) -> Void)?
    var error: ((String) -> Void)?
}
