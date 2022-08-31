//
//  SignUp.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 23/3/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SignUp : BaseVC {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var viewUsername: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewConfirmPassword: UIView!
    @IBOutlet weak var btnPasswordEye: UIButton!
    @IBOutlet weak var btnCPasswordEye: UIButton!
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var btnProfileImage: UIButton!
    
    var db : Firestore?
    var imgName : String?
    var imgData : Data?
    var imgUI : UIImage?
    var imagePicker: ImagePicker! = nil
    var visiable = true
    var visiable1 = true
    let imgEyeSlash = UIImage(named: "ic_eye_slash")
    let imgEye = UIImage(named: "ic_eye")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.db = Firestore.firestore()
        updateUI()
    }
    
    func updateUI() {
        self.navigationController?.navigationBar.isHidden = true
        viewBackground.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let height = self.imgProfileImage.frame.height / 2
        imgProfileImage.layer.cornerRadius = height
    }
    
    @IBAction func clickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickSignIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickImagePicker(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
    }
    
    @IBAction func clickSignUp(_ sender: Any) {
        if isValidate() {
            createUser(withEmail: self.tfEmail.text ?? "", username: self.tfUsername.text ?? "", password: self.tfPassword.text ?? "", phoneNo: self.tfPhone.text ?? "")
        }
    }
    
    
    //MARK: Password Security TextField
    @IBAction func clickPasswordEye(_ sender: Any) {
        if visiable == true {
            tfPassword.isSecureTextEntry = false
            btnPasswordEye.setImage(imgEyeSlash, for: .normal)
        } else {
            tfPassword.isSecureTextEntry = true
            btnPasswordEye.setImage(imgEye, for: .normal)
        }
        visiable = !visiable
    }
    
    @IBAction func clickCPasswordEye(_ sender: Any) {
        if visiable1 == true {
            tfConfirmPassword.isSecureTextEntry = false
            btnCPasswordEye.setImage(imgEyeSlash, for: .normal)
        } else {
            tfConfirmPassword.isSecureTextEntry = true
            btnCPasswordEye.setImage(imgEye, for: .normal)
        }
        visiable1 = !visiable1
    }
    
    //MARK: is Validate
    func isValidate() -> Bool {
        var isValid = true
        if self.tfUsername.text?.isEmpty ?? true {
            self.viewUsername.backgroundColor = .red
            isValid = false
        }
        if self.tfEmail.text?.isEmpty ?? true {
            self.viewEmail.backgroundColor = .red
            isValid = false
        }
        if self.tfPhone.text?.isEmpty ?? true {
            self.viewPhone.backgroundColor = .red
            isValid = false
        }
        if self.tfPassword.text?.isEmpty ?? true {
            self.viewPassword.backgroundColor = .red
            isValid = false
        }
        if self.tfConfirmPassword.text?.isEmpty ?? true {
            self.viewConfirmPassword.backgroundColor = .red
            isValid = false
        }
        if self.tfPassword.text != self.tfConfirmPassword.text {
            self.viewPassword.backgroundColor = .red
            self.viewConfirmPassword.backgroundColor = .red
            isValid = false
        }
        return isValid
    }
}

extension SignUp {
    
    //MARK: Sign Up User
    func createUser(withEmail email: String, username: String, password: String, phoneNo: String) {
        if imgUI != nil {
            self.imgName = String.random()
            self.imgData = UIImage().compressImage(imgUI!, width: 500, height: 500)
            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(self.imgName!).png")
            do {
                try self.imgData?.write(to: fileURL, options: .atomic)
            } catch {
                print("Image Cannot Compress")
            }
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if let error = err as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .emailAlreadyInUse:
                        self.showError(title: "Invalid Email" , msg: "Email Already Used" , okbtnText: "OK")
                    case .invalidEmail:
                        self.showError(title: "Invalid Email", msg: "Email is Invalid", okbtnText: "OK")
                    default :
                        self.showError(title: "Error", msg: "Error, \(error.localizedDescription)", okbtnText: "OK")
                    }
                }
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let ImageRef = storageRef.child("ProfileImage/\(self.imgName!).png")
                ImageRef.putFile(from: fileURL, metadata: nil) { metadata, error in
                    guard metadata != nil else { return }
                }
                guard let uid = result?.user.uid else { return }
                let values = ["email": email, "phone": phoneNo, "username": username, "image": "\(self.imgName!).png"]
                self.db?.collection("users").document(uid).setData(values) { err in
                    if let error = err {
                        print("\(error.localizedDescription)")
                    } else {
                        print("Successfully Document written")
                        let vc = HomeTabBarController.initiate(appStoryBoard: .HomeTabBarController)
                        let navController = UINavigationController(rootViewController: vc)
                        navController.modalPresentationStyle = .fullScreen
                        self.present(navController, animated: false, completion: nil)
                    }
                }
            }
        } else {
            self.showError(title: "Missing Profile Image", msg: "Please choose profile image", okbtnText: "OK")
        }
    }
}

//MARK: Image Picker
extension SignUp: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if image != nil {
            self.imgUI = image
            self.imgProfileImage.image = image
        }
    }
}
