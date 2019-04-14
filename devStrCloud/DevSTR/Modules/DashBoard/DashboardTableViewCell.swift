//
//  DashboardTableViewCell.swift
//  DevSTR
//
//  Created by PRoVMac on 13/02/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var posterName: UILabel!
    
    @IBOutlet weak var posterDesignation: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
