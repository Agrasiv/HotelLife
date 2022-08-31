//
//  AppStoryboard.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 23/3/22.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    
    case Main = "Main"
    case SignUp = "SignUp"
    case HomeTabBarController = "HomeTabBarController"
    case Alert = "Alert"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboard = viewControllerClass.storyboardID
        return instance.instantiateViewController(withIdentifier: storyboard) as! T
    }
}
