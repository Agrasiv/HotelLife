//
//  ViewController.swift
//  HotelLife
//
//  Created by Pyae Phyo Oo on 21/3/22.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class ViewController: BaseVC {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userDefault()
    }
    
    func updateUI() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    func userDefault() {
        let userInfo = Auth.auth().currentUser
        let email = userInfo?.email
        if email != nil {
            let vc = HomeTabBarController.initiate(appStoryBoard: .HomeTabBarController)
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: false, completion: nil)
        }
    }
    
    @IBAction func clickSignUp(_ sender: Any) {
        let vc = SignUp.initiate(appStoryBoard: .SignUp)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickLogIn(_ sender: Any) {
        userLogIn(withEmail: self.tfEmail.text ?? "", password: self.tfPassword.text ?? "")
    }
    
    @IBAction func clickFacebook(_ sender: Any) {
        facebookAuth()
    }
    
    @IBAction func clickGoogle(_ sender: Any) {
        googleAuth()
    }
    
    
    //MARK: is Validate
    func isValidate() -> Bool {
        var isValid = true
        if self.tfEmail.text?.isEmpty ?? true {
            self.viewEmail.backgroundColor = UIColor.red
            isValid = false
        }
        if self.tfPassword.text?.isEmpty ?? true {
            self.viewPassword.backgroundColor = UIColor.red
            isValid = false
        }
        return isValid
    }
}

extension ViewController {
    
    //MARK: Authentication with Username and Password
    func userLogIn(withEmail email: String, password: String) {
        if isValidate() {
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if let error = err as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                        self.showError(title: "Operation Not Allowed", msg: "Please Try Again", okbtnText: "OK")
                    case .userDisabled:
                        self.showError(title: "User Disable", msg: "User Not Found", okbtnText: "OK")
                    case .wrongPassword:
                        self.showError(title: "Wrong Password", msg: "Please Check Password", okbtnText: "OK")
                    case .invalidEmail:
                        self.showError(title: "Invalid Email", msg: "Email is Invalid", okbtnText: "OK")
                    default:
                        self.showError(title: "Error", msg: "Error, \(error.localizedDescription)", okbtnText: "OK")
                    }
                }
                let email = result?.user.email
                if email != nil {
                    let vc = HomeTabBarController.initiate(appStoryBoard: .HomeTabBarController)
                    let navController = UINavigationController(rootViewController: vc)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: false, completion: nil)
                }
            }
        }
    }
    
    //MARK: Authentication with Facebook
    func facebookAuth() {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, err) in
            if let error = err {
                print("Failed to logIn \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential, completion: { (fbuser, err) in
                if let error = err {
                    self.showError(title: "Error", msg: "\(error.localizedDescription)", okbtnText: "OK")
                    return
                }
                if fbuser != nil {
                    let vc = HomeTabBarController.initiate(appStoryBoard: .HomeTabBarController)
                    let navController = UINavigationController(rootViewController: vc)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: false, completion: nil)
                }
            })
        }
    }
    
    //MARK: Authentication with Google
    func googleAuth() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { (result, err) in
            if let error = err {
                self.showError(title: "Error", msg: "\(error.localizedDescription)", okbtnText: "OK")
                return
            }
            guard let authentication = result?.authentication,
                  let tokenID = authentication.idToken else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: tokenID, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { (googleuser, err) in
                if let error = err {
                    print("Login error: \(error.localizedDescription)")
                    return
                }
                if googleuser != nil {
                    let vc = HomeTabBarController.initiate(appStoryBoard: .HomeTabBarController)
                    let navController = UINavigationController(rootViewController: vc)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: false, completion: nil)
                }
            }
        }
    }
    
    //MARK: Authentication with Twitter
//    func twitterAuth() {
//        var provider = OAuthProvider(providerID: "twitter.com")
//
//    }
}

