//
//  ConfirmVC.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 31/3/22.
//

import Foundation
import UIKit

class ConfirmVC : UIViewController {
    
    @IBOutlet weak var viewConfirm: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    
    var alertTitle : String?
    var message : String?
    var btnokText : String?
    var btncancelText : String?
    var action : (() -> Void)?
    
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
    
    @IBAction func clickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//MARK: New Instance
    static func newInstance(title: String?, message: String?, okButtonText: String?, cancelButtonText: String?, action: (() -> Void)?) -> ConfirmVC {
        let vc = ConfirmVC.initiate(appStoryBoard: .Alert)
        vc.alertTitle = title
        vc.message = message
        vc.btnokText = okButtonText
        vc.btncancelText = cancelButtonText
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }
    
//MARK: UpdateUI
    func updateUI() {
        lbTitle.text = alertTitle
        lbMessage.text = message
        btnOK.setTitle(btnokText, for: .normal)
        btnCancel.setTitle(btncancelText, for: .normal)
    }
}

