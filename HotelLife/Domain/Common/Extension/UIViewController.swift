//
//  UIViewController.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 23/3/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func initiate(appStoryBoard : AppStoryboard) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    @objc func dismissView() {
        self.dismiss(animated: false, completion: nil)
    }
}
