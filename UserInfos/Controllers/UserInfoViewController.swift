//
//  UserInfoViewController.swift
//  UserInfo
//
//  Created by Anis Mansuri on 12/10/19.
//  Copyright © 2019 Anis Mansuri. All rights reserved.
//

import UIKit

class UserInfoViewController: BaseViewController {
    @IBOutlet private weak var tableView: UserTableView!
    
    var person: Person?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func setup() {
        guard let person: Person = person else { return }
        let user = User(person: person)
        tableView.values = user.dataAsArray
        tableView.reloadData()
        backButtonType = .logout
        
    }
    override func backButtonTapHandler(sender: UIButton) {
        
        UIAlertController.showAlert(message: .logout, buttonTitles: ["Yes", "No"]) { [unowned self] index in
            if index == 0 {
//                KeyChain.removePassword()
                Keychain.removeValue(forKey: kPassword)

                guard let person: Person = self.person else { return }
                Core.shared.delete([person])
                UIApplication.shared.setRootViewController(viewController: SignUpViewController.loadController())
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
