//
//  profileViewController.swift
//  DevSTR
//
//  Created by ShreeThaanu on 13/02/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import UIKit

class profileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier:" profileTableViewCell", for: indexPath) as! profileTableViewCell
        cell.textLabel?.text = "Profile"
        return cell
        
    }
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var profileDesigmnation: UILabel!
    
    @IBOutlet weak var profileTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}
