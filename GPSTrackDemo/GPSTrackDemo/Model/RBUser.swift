//
//  RBUser.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

/// Signleton class which holds loggedin user's information
class RBUser: NSObject,NSCoding {
    static public let current = RBUser.init()
    

    
    /// User ID
    var sessionIdGps:String = ""
    
    /// username of the user
    var userIdApp:String = ""
    
  
    
    private override init() {
        super.init()
        
        if let encodeObject:Data = UserDefaults.standard.object(forKey: "CurrentUser") as? Data{
            // User Found
            if let savedObj:RBUser = NSKeyedUnarchiver.unarchiveObject(with: encodeObject) as? RBUser{
                self.sessionIdGps = savedObj.sessionIdGps
                self.userIdApp = savedObj.userIdApp
//                self.username = savedObj.username
            }
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.sessionIdGps, forKey: "sessionIdGps")
        aCoder.encode(self.userIdApp, forKey: "userIdApp")
//        aCoder.encode(self.email, forKey: #keyPath(RBUser.email))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.sessionIdGps = aDecoder.decodeObject(forKey: "sessionIdGps") as? String ?? ""
        self.userIdApp = aDecoder.decodeObject(forKey:"userIdApp") as? String ?? ""
//        self.email = aDecoder.decodeObject(forKey: #keyPath(RBUser.email)) as? String ?? ""
    }
    
    
    
    func save() -> Void {
        //self.selectedStore?.save()
        do{
            let currentUserRef = NSKeyedArchiver.archivedData(withRootObject: self)
            
            UserDefaults.standard.set(currentUserRef, forKey: "CurrentUser")
            UserDefaults.standard.synchronize()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func isUserloggedIn() -> Bool {
        return !self.sessionIdGps.isEmpty
    }
    
    func resetDetails() -> Void {
        sessionIdGps = ""
        userIdApp = ""
        
        self.save()
    }
    
    func updateDetails(WithContent content:[String:Any]) -> Void {
        if let value = content["sessionIdGps"] as? String{
            self.sessionIdGps = value
        }
        if let value = content["userIdApp"] as? String{
            self.userIdApp = value
        }
       
        save()
    }
    
   
//    func updateDetails(WithContent content:MSFirebaseManager.AuthenticationInfo) -> Void{
//        self.email = content.email
//    }
}
