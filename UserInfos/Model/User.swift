//
//  User.swift
//  UserInfo
//
//  Created by Anis Mansuri on 12/10/19.
//  Copyright © 2019 Anis Mansuri. All rights reserved.
//

import Foundation
struct User {
    var fullName, userName, email, mobile, dob, password: String?
    
    var age: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        guard let birthday = formatter.date(from: dob ?? "") else { return 0 }
        let ageComponents = Calendar.current.dateComponents([.year], from: birthday, to: Date())
        return ageComponents.year ?? 0
    }
    var dataAsArray: [String] {
        return ["Name: \(fullName.value)",
            "User Name: \(userName.value)",
            "Email: \(email.value)",
            "Mobile: \(mobile.value)",
            "Date of birth: \(dob.value)",
            "Age: \(age)",
        ]
    }
    static var allData: User {
        return User(fullName: "Anis Mansuri", userName: "anismansuri63", email: "anismansuri63@gmail.com", mobile: "+91 9574850843", dob: "03/10/1993", password: "1345")
    }
}
extension User {
    init(person: Person) {
        fullName = person.fullName
        userName = person.userName
        email = person.email
        mobile = person.mobile
        dob = person.dob
    }
}
extension Person {
    func addDataInStack(user: User){
        fullName = user.fullName
        userName = user.userName
        email = user.email
        mobile = user.mobile
        dob = user.dob
    }
}
