//
//  TextField.swift
//  UserInfo
//
//  Created by Anis Mansuri on 12/10/19.
//  Copyright © 2019 Anis Mansuri. All rights reserved.
//

import UIKit
enum FieldType {
    case fullName, userName, email, password, mobile, dob, none

    var palceHolder: String {
        switch self {
        case .fullName:
            return "Please enter full name."
        case .userName:
            return "Please enter username."
        case .email:
            return "Please enter email address."
        case .password:
            return "Please enter password."
        case .mobile:
            return "Please enter mobile number."
        case .dob:
            return "Please select date of birth."
        case .none:
            return ""
        }
    }

    var isSecureTextEntry: Bool {
        return self == .password
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .mobile:
            return .phonePad

        default:
            return .default
        }
    }
}

class TextField: UITextField {
    var fieldType: FieldType = .none {
        didSet {
            self.placeholder = fieldType.palceHolder
            self.isSecureTextEntry = fieldType.isSecureTextEntry
            self.keyboardType = fieldType.keyboardType
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        addBorder()
    }
}

class DatePickerTextField: TextField {
    lazy var datePicker: UIDatePicker = {
        let dateP = UIDatePicker()
        dateP.datePickerMode = .date
        dateP.maximumDate = Date()
        // ToolBar
        
        return dateP
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        addBorder()
    }

    override func setup() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        // done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))

        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)

        // add toolbar to textField
        inputAccessoryView = toolbar
        // add datepicker to textField
        inputView = datePicker
    }

    @objc func donedatePicker() {
        // For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.text = formatter.string(from: datePicker.date)
        
        resignFirstResponder()
    }

    @objc func cancelDatePicker() {
        // cancel button dismiss datepicker dialog
        resignFirstResponder()
    }
}
