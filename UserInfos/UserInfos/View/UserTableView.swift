//
//  UserTableView.swift
//  UserInfos
//
//  Created by Anis Mansuri on 12/10/19.
//  Copyright © 2019 Anis Mansuri. All rights reserved.
//

import UIKit

class UserTableView: UITableView {
    var values: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    func setup() {
        dataSource = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
extension UserTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return values.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = values[indexPath.row]
        return cell
    }
}
