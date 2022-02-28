//
//  MSServiceManager.swift
//  MVVM Demo
//
//  Created by Malav Soni on 03/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import Alamofire


class MSServiceManager: NSObject {
    
    static let shared:MSServiceManager = MSServiceManager()
    var sessionId:String = ""
    var userAppId:String = ""
    typealias APIResponseHandler = ((Bool,Any?,String)->())
    typealias APIResponseStandardDictionaryHandler = ((Bool,[String:Any],String)->())
    typealias APILoginResponseHandler = ((Bool,String)->())
    
//    private var localizeAlertStrings = ValidationMessages()
    
    enum APIEndPoint:String {
      
           static var APIBaseURL = "http://my.yodiyil.com/v2/api/mobile/"
            
            case loginAPI = "login.php?"
           
           case getAllDevices = "devices.php?sessionIdGps=JSESSIONID=node018xhwtknoz7en1ozfmrd4g9ail292.node0&userIdApp=5"
           
        case getAllPositions = "positions.php?sessionIdGps=JSESSIONID=node018xhwtknoz7en1ozfmrd4g9ail292.node0&userIdApp=5&id=181368"
        
          
            var apiURL:String {
               return "\(APIEndPoint.APIBaseURL)\(self.rawValue)"
           }
           
           var httpMethod:HTTPMethod{
               switch self {
               default:
                   return .post
               }
           }
           
           var parameterEncoding:ParameterEncoding{
               switch self.httpMethod {
               case .post:
                   return JSONEncoding.default
               default:
                   return URLEncoding.default
               }
           }
       }
    
    func isInternetAvailable() -> Bool{
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    private func callAPI(WithEndPoint endPoint:APIEndPoint,
                             AndParameters params:[String:Any],
                             shouldShowInternetAlertOnFailure shouldShowInternetAlert:Bool,
                             shouldShowLoader showLoader:Bool,
                             shouldHideLoader hideLoader:Bool,
                             WithCompletion completion:@escaping APIResponseHandler) -> Void{
            
            guard self.isInternetAvailable() else {
                if shouldShowInternetAlert{
                    UIAlertController.alert(message: "Internet error 1")
                }
                completion(false,[:],"Connection Error")
                return
            }
            
            if showLoader{
                MSLoader.shared.showLoader()
            }
            
            let mutableParameters = params
    //        mutableParameters[Parameters.Key.ModelNo.rawValue] = UIDevice.modelName
    //        mutableParameters[Parameters.Key.DeviceID.rawValue] = UIDevice.current.identifierForVendor?.uuidString ?? ""
            
            var headers:HTTPHeaders = [:]
            headers["Content-Type"] = "application/json"
            headers["Content-Type"] = "application/x-www-form-urlencoded"
            guard let apiURL = URL.init(string: endPoint.apiURL) else { return }
            
            #if DEBUG
            print("\(String(describing: endPoint.httpMethod)) API URL : \(apiURL)\nHeaders : \(headers)\nParams : \(mutableParameters)")
            #endif
        
        AF.request(apiURL, method: endPoint.httpMethod, parameters: mutableParameters, encoding: endPoint.parameterEncoding, headers: headers, interceptor: .none, requestModifier: .none).responseData { (serverResponse) in
            
        }
            
        }
}

extension MSServiceManager{
    
    // Country Module API
    func getDeviceList(withCompletion completion:(([RBDevices],Error?)->())?) -> Void{
        let halfurl =  "devices.php?sessionIdGps=\(RBUser.current.sessionIdGps)&userIdApp=\(RBUser.current.userIdApp)"
//        let url: String = APIEndPoint.getAllDevices.apiURL
        let url: String = APIEndPoint.APIBaseURL+halfurl
        
       print(url)
        AF.request(url, method: .get,  parameters: nil, encoding: JSONEncoding.default)
    
            .responseJSON { (response) in
            switch response.result{
            case .success( _):
                print(response)
                guard let jsonData = response.data else {
                    return
                }
                do {
                    
                    if(jsonData.count > 0)
                    {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let data = try decoder.decode(RBData.self, from: jsonData)

                        completion?(data.data,nil)
                    }
                    else
                    {
                        completion?([],nil)
                    }
                    
                }catch(let error){
                    completion?([],error)
                }
                break
            case .failure(let error):
                completion?([],error)
                break
            }
        }
    }
}

extension MSServiceManager{
    
    // Country Module API
    func getPositionList(withCompletion completion:(([RBPositions],Error?)->())?) -> Void{
        
        let halfurl =  "positions.php?sessionIdGps=\(RBUser.current.sessionIdGps)&userIdApp=\(RBUser.current.userIdApp)&id=181368"
        
        let url: String = APIEndPoint.APIBaseURL+halfurl
        
        
       print(url)
        AF.request(url, method: .get,  parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success( _):
                print(response)
                guard let jsonData = response.data else {
                    return
                }
                do {
                    
                    if(jsonData.count > 0)
                    {
                        let decoder = JSONDecoder()
//                        decoder.dateDecodingStrategy = .iso8601
                        let data = try decoder.decode(RBPositionData.self, from: jsonData)
                        print(data)
                        completion?(data.data,nil)
                    }
                    else
                    {
                        completion?([],nil)
                    }
                    
                }catch(let error){
                    print(error.localizedDescription)
                    completion?([],error)
                }
                break
            case .failure(let error):
                completion?([],error)
                break
            }
        }
    }
}

