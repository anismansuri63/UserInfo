//
//  LoginViewController.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 06/01/22.
//

import UIKit





class LoginViewController: UIViewController {
    
 
    @IBOutlet weak var textFieldEmailId: RBTextField!
    @IBOutlet weak var textFieldPassword: RBTextField!
    
    
    @IBOutlet weak var btnSignIn: RBButton!
    @IBOutlet weak var btnForgotPass: RBButton!
    //    @IBOutlet weak var btnForgotPass: !
    
    private var viewModel:LoginViewModel!
    
    @IBOutlet weak var viewLogin: UIView!
    
    var sessionId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel = LoginViewModel(withDelegate: self)
        self.setUpUI()
        self.setUpController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
       }


    
   private func setUpUI() -> Void {
       
    self.navigationItem.setHidesBackButton(true, animated: true)
    self.navigationItem.titleView?.tintColor = .black

    // View UI
    self.viewLogin.addGlowEffect()
    self.viewLogin.addCornerRadius()
    
    self.btnSignIn.buttonStyle = .large
    self.btnForgotPass.buttonStyle = .none
//       self.textFieldEmailId.text = "kamaal"
//       self.textFieldPassword.text = "kainos123"
    }
    
    func  setUpController() -> Void {
        self.viewModel = LoginViewModel(withDelegate: self)
    }
    
    
    @IBAction func btnSignIn_Action(_ sender: UIButton) {
        print("Login Cliecked")
        self.viewModel.validateCredentials(withEmail: self.textFieldEmailId.text ?? "", andPassword: self.textFieldPassword.text ?? "")
    }
    
}

//MARK:- LoginViewModelProtocol
extension LoginViewController:LoginViewModelProtocol{
        
    func userLoggedInSuccessfully(data: Any) {
        
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GPSTrackViewController") as? GPSTrackViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            UserDefaults.standard.set(true, forKey: "is_login")
            print("Logged in successfully")
    }
    
    func failedToLoggedIn(withErrorMessage errorMessage: String) {
        UIAlertController.showActionSheet(andMessage: errorMessage, andButtonTitles: [], andCancelButton: "OK", andSelectionHandler: nil)
    }
    
}
 
