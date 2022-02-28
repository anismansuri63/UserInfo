//
//  LoginViewModel.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 06/01/22.
//

import Foundation
import Alamofire

typealias ValidationStatus = (status:Bool,errorMessage:String)


protocol LoginViewModelProtocol:class {
    func userLoggedInSuccessfully(data:Any) -> Void
    func failedToLoggedIn(withErrorMessage errorMessage:String) -> Void
}

class LoginViewModel:NSObject{
    weak private var delegate:LoginViewModelProtocol?
//    private var countryInfo:Country
    
    init(withDelegate delegate:LoginViewModelProtocol) {
        super.init()
        self.delegate = delegate
    }
    
    
    func validateCredentials(withEmail email:String, andPassword password:String) -> Void {
        
        var validationResult = self.validate(email: email)
        
        guard validationResult.status == true else {
            self.delegate?.failedToLoggedIn(withErrorMessage: validationResult.errorMessage)
            return
        }
        
        // Validate Password
        validationResult = self.validate(password: password)
        guard validationResult.status == true else {
            self.delegate?.failedToLoggedIn(withErrorMessage: validationResult.errorMessage)
            return
        }
        
        // Check for Internet Connection
//        guard MSServiceManager.shared.isInternetAvailable() else {
//            self.delegate?.failedToLoggedIn(withErrorMessage: ValidationMessages().internetConnectionError)
//            return
//        }
        
        // Call Login API
        //self.delegate?.userLoggedInSuccessfully(data: [])
        self.Login(name: email, password: password) { (data) in
            print(data)
            
            
            if((data) != nil)
                       {
                           if let firstObject = data?.first as? [String:Any]{
                               RBUser.current.updateDetails(WithContent: firstObject)
                               self.delegate?.userLoggedInSuccessfully(data: RBUser.current)
                           }
                       }
                       else
                       {
                           self.delegate?.failedToLoggedIn(withErrorMessage: "Login Failed")
                       }

        }

    }
    
    
}

// Validate your inputs
extension LoginViewModel{
    func validate(email:String?) -> ValidationStatus {
        guard let emailValue = email,emailValue.isEmpty == false else {
//            return (false,localizeStrings.enterEmail)
            return (false,"Please Enter Email")
        }
        if emailValue.isValidEmail() == false{
//            return (false,localizeStrings.enterValidEmail)
            return (false,"Please Enter Valid Email")
        }
        return (true,"")
    }
    
    func validate(password:String?) -> ValidationStatus {
        guard let passwordValue = password, passwordValue.isEmpty == false else {
            return (false,"Please Enter Email")
        }
        return (true,"")
    }
}

extension LoginViewModel{
    
    func Login(name:String,password:String,complete: @escaping ([NSDictionary]?) -> ()) -> Request {
        let name1 = "kamaal"
            let password2 = "kainos123"
        var url : String = MSServiceManager.APIEndPoint.APIBaseURL
        url = url + "login.php?username=\(name)&password=\(password)&notificationToken=x"
        
        return AF.request(url,
                     method: .get,
                     parameters: nil,
                     encoding: JSONEncoding.default,
                     headers: nil)
            .validate(statusCode: 200..<500)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    switch response.response?.statusCode {
                    case 200, 204:
                        /// Handle success, parse JSON data
                        
                        do {
                            print(data)
                            if let dict = data as? NSDictionary{
                                if let response = dict.value(forKey: "response") as? [String:Any]{
                                    if let responseCode = response["responseCode"] as? String , response["responseCode"] as! String == "200" {
                                        if let data = dict.value(forKey: "data") as? [NSDictionary]{
                                            complete(data)
                                            return
                                        }
                                    }else{
                                        self.delegate?.failedToLoggedIn(withErrorMessage: "Login Failed")
                                        return

                                    }
                                   
                                    
                                    
                                }
                               
                            }
                            complete(nil)
                            //self.delegate?.userLoggedInSuccessfully(data: data)
                            
//                            let users = try JSONDecoder().decode(RBUser.self, from: JSONSerialization.data(withJSONObject: data))
//                            print(users)
//                            complete(.Success(UserListAPIResponseData(users: users)))
                        } catch let error {
                            /// Handle json decode error
                            print(error)
                            self.delegate?.failedToLoggedIn(withErrorMessage: "Login Failed")
//                             complete(.Fail(APIError(code: -1, message: "we ran into error")))
                        }
                        
                    case 400:
                        self.delegate?.failedToLoggedIn(withErrorMessage: "Login Failed")


                    case 429:
                        /// Handle 429 error
                    print("429")
//                        complete(.Fail(APIError(code: 429, message: "we ran into error")))
                    default:
                        /// Handle unknown error
                        print("429")
//                        complete(.Fail(APIError(code: -1, message: "we ran into error")))
                    }
                case .failure(let error):
                    /// Handle request failure
                    print(error)
//                    complete(.Fail(APIError(code: 0, message: "we ran into error")))
                }
            })
    }
    
}

