//
//  WorldTimeTableViewCell.swift
//  Clock
//
//  Created by Wongil on 2022/03/24.
//

import UIKit

class WorldTimeTableViewCell: UITableViewCell {
    @IBOutlet var lblDiffTime: UILabel!
    @IBOutlet var lblArea: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
