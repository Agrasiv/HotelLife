//
//  Profile.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 29/3/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import SDWebImage

class Profile : BaseVC {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        getUserInfo()
    }
    
    func updateUI() {
        let height = imgProfile.frame.height / 2
        imgProfile.layer.cornerRadius = height
    }
    
    //MARK: Get UserInfo by provider
    func getUserInfo() {
        let providerData = Auth.auth().currentUser!.providerData
        for providers in providerData {
            let providerID = providers.providerID
            let provider = AuthProvider(rawValue: "\(String(describing: providerID))")
            switch provider {
            case .facebook:
                providerUser()
            case .emailPassword:
                emailUser()
            case .google:
                providerUser()
            case .twitter:
                print("twitter")
            case .none:
                print("Error")
            }
        }
    }
    
    //MARK: Provider User Profile
    func providerUser() {
        let user = Auth.auth().currentUser
        let imageURL = (user?.photoURL!.absoluteString)! + "?width=\(500)&height=\(500)"
        imgProfile.sd_setImage(with: URL(string: imageURL), completed: nil)
        lbName.text = user?.displayName
        lbEmail.text = user?.email
        if user?.phoneNumber == nil {
            lbPhone.text = " - "
        } else {
            lbPhone.text = user?.phoneNumber
        }
    }
    
    //MARK: Email User Profile
    func emailUser() {
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("users").document(userID!).getDocument { (user, err) in
            if let error = err {
                print("Error Data fatch \(error)")
            }
            guard let result = user?.data() else { return }
            self.lbName.text = result["username"] as? String
            self.lbEmail.text = result["email"] as? String
            self.lbPhone.text = result["phone"] as? String
            let image = result["image"] as? String ?? ""
            let imgURL = Constants.API.imageURL + image + "?alt=media"
            self.imgProfile.sd_setImage(with: URL(string: imgURL), completed: nil)
        }
    }
    
    //MARK: Log Out
    @IBAction func clickLogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let vc = ViewController.initiate(appStoryBoard: .Main)
            let NavContoller = UINavigationController(rootViewController: vc)
            NavContoller.modalPresentationStyle = .fullScreen
            self.present(NavContoller, animated: false, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
