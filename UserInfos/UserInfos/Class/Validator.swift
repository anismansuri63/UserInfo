//
//  Validators.swift
//  UserInfo
//
//  Created by Anis Mansuri on 12/10/19.
//  Copyright © 2019 Anis Mansuri. All rights reserved.
//

import Foundation
struct ValidationError: Error {
    var message: String
}

struct Validator {
    static func fullNameValidate(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError(message: "Full name must contain more than three characters")
        }
        guard value.count < 50 else {
            throw ValidationError(message: "Full name shoudn't conain more than 50 characters")
        }
        return value
    }

    static func userNamevalidate(_ value: String) throws -> String {
        // "^[a-z]{1,18}$"
        guard value.count >= 4 else {
            throw ValidationError(message: "Username must contain more than 4 characters")
        }
        guard value.count < 20 else {
            throw ValidationError(message: "Username shoudn't conain more than 20 characters")
        }

        do {
            if try NSRegularExpression(pattern: "^[0-9a-zA-Z\\_]{7,18}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(message: "Invalid username.")
            }
        } catch {
            throw ValidationError(message: "Invalid username.")
        }
        return value
    }

    static func mobileValidate(_ value: String) throws -> String {
        let reg = "^(\\+91[\\-\\s]?)?[0]?(91)?[789]\\d{9}$"

        do {
            if try NSRegularExpression(pattern: reg, options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(message: "Invalid mobile number")
            }
        } catch {
            throw ValidationError(message: "Invalid mobile number")
        }
        return value
    }
    static func emailValidate(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(message: "Invalid email Address")
            }
        } catch {
            throw ValidationError(message: "Invalid email Address")
        }
        return value
    }
    static func dobValidate(_ value: Int) throws -> String {
        
        guard value > 17 else { throw ValidationError(message: "Age must be 18+") }
        return "\(value)"
    }

    static func passwordValidate(_ value: String) throws -> String {
        guard value != "" else { throw ValidationError(message: "Password is Required") }
        guard value.count >= 8 else { throw ValidationError(message: "Password must have at least 8 characters") }

        do {
            if try NSRegularExpression(pattern: "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(message: "Password must be more than 8 characters, with at least one capital character, one special character and one numeric character")
            }
        } catch {
            throw ValidationError(message: "Password must be more than 8 characters, with at least one capital character, one special character and one numeric character")
        }
        return value
    }
}
