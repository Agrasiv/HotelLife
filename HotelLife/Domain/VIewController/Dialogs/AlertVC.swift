//
//  AlertVC.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 31/3/22.
//

import Foundation
import UIKit

class AlertVC : UIViewController {
    
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    
    var action : (() -> Void)?
    var alertTitle : String?
    var message : String?
    var okbtnText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    @IBAction func clickOK(_ sender: Any) {
        self.dismiss(animated: true) {
            self.action?()
        }
    }
    
// MARK: NewInstance
    static func newInstance(title: String?, message: String?, okButtonText: String?, action: (() -> Void)?) -> AlertVC {
        let vc = AlertVC.initiate(appStoryBoard: .Alert)
        vc.alertTitle = title
        vc.message = message
        vc.okbtnText = okButtonText
        vc.action = action
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }
    
//MARK: UpdateUI for AlertVC
    func updateUI() {
        self.lbTitle.text = alertTitle
        self.lbMessage.text = message
        self.btnOK.setTitle(okbtnText, for: .normal)
    }
    
}
