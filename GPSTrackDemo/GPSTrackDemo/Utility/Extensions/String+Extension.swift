//
//  String+Extension.swift
//  LoginMVVM
//
//  Created by Ruchika Bokadia on 04/01/22.
//

import Foundation

extension String{
    
    
    func isValidEmail() -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailRegEx = "[A-Z0-9a-z._%+-]"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: self)
        return true
    }
    
    func isValidPassword() -> Bool {
        let strPasswordValue = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return strPasswordValue.count >= 8
    }
    
    func trimBlankSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
}
