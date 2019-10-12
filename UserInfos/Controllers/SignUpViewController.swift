//
//  SignUpViewController.swift
//  UserInfo
//
//  Created by Anis Mansuri on 12/10/19.
//  Copyright © 2019 Anis Mansuri. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    @IBOutlet private var textFieldFullName: TextField!
    @IBOutlet private var textFieldUserName: TextField!
    @IBOutlet private var textFieldEmail: TextField!
    @IBOutlet private var textFieldDob: DatePickerTextField!
    @IBOutlet private var textFieldMobile: TextField!
    @IBOutlet private var textFieldPassword: TextField!

    @IBOutlet private var buttonSignUp: UIButton!

//    private var user = User.allData
    private var user = User()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setup() {
        textFieldFullName.fieldType = .fullName
        textFieldUserName.fieldType = .userName
        textFieldEmail.fieldType = .email
        textFieldDob.fieldType = .dob
        textFieldMobile.fieldType = .mobile
        textFieldPassword.fieldType = .password

        textFieldFullName.text = user.fullName
        textFieldUserName.text = user.userName
        textFieldEmail.text = user.email
        textFieldDob.text = user.dob
        textFieldMobile.text = user.mobile
        textFieldPassword.text = user.password
        _ = [textFieldFullName, textFieldUserName, textFieldEmail, textFieldDob, textFieldMobile, textFieldPassword].map {
            $0?.delegate = self
        }
    }

    @IBAction private func buttonSignUpPressed(_ sender: UIButton) {
        view.endEditing(true)
        validate()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let type = (textField as? TextField)?.fieldType, let text = textField.text else { return true }
        switch type {
        case .fullName:
            textFieldUserName.becomeFirstResponder()
        case .userName:
            textFieldEmail.becomeFirstResponder()
        case .email:
            textFieldDob.becomeFirstResponder()
        case .mobile:
            textFieldPassword.becomeFirstResponder()
        case .dob:
            textFieldMobile.becomeFirstResponder()
        default: break
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let type = (textField as? TextField)?.fieldType, let text = textField.text else { return }
        switch type {
        case .fullName:
            user.fullName = text
        case .userName:
            user.userName = text
        case .email:
            user.email = text
        case .password:
            user.password = text
        case .mobile:
            user.mobile = text
        case .dob:
            user.dob = text
        case .none:
            print("no value")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)

    }
}

private extension SignUpViewController {
    func validate() {
        do {
            // Full Name
            _ = try Validator.fullNameValidate(user.fullName.value)

            // User Name
            _ = try Validator.userNamevalidate(user.userName.value)

            // Email
            _ = try Validator.emailValidate(user.email.value)

            // DOB
            _ = try Validator.dobValidate(user.age)

            // Mobile
            _ = try Validator.mobileValidate(user.mobile.value)

            // Password
            let password = try Validator.passwordValidate(user.password.value)
//            let password = user.password.value

            let person = Person(context: Core.shared.persistentContainer.viewContext)
            person.addDataInStack(user: user)
            person.save()
//            KeyChain.saveUserPassword(value: password)
            Keychain.set(password, forKey: kPassword)
            ActivityLoader.shared.show()
            delay(1.5) { [weak self] in
                ActivityLoader.shared.hide()
                let userVC = UserInfoViewController.loadController()
                userVC.person = person
                UIApplication.shared.setRootViewController(viewController: userVC)
            }
        } catch let error {
            UIAlertController.showAlert(message: (error as! ValidationError).message)
        }
    }
    
}
