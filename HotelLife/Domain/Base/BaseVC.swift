//
//  BaseVC.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 31/3/22.
//

import Foundation
import UIKit

class BaseVC : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: DialogShow
extension BaseVC {
    
    public func showError(title: String, msg: String, okbtnText: String) {
        let vc = AlertVC.newInstance(title: title, message: msg, okButtonText: okbtnText, action: nil)
        self.present(vc, animated: false, completion: nil)
    }
    
    public func showConfirm(title: String, msg: String, okbtnText: String, cancelbtnText: String) {
        let vc = ConfirmVC.newInstance(title: title, message: msg, okButtonText: okbtnText, cancelButtonText: cancelbtnText, action: nil)
        self.present(vc, animated: false, completion: nil)
    }
    
    func dateString(datepicker: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let realDate = dateFormatter.string(from: datepicker)
        return realDate
    }
}
