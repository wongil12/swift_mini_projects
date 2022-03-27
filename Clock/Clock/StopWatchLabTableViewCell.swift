//
//  StopWatchLabTableViewCell.swift
//  Clock
//
//  Created by Wongil on 2022/03/27.
//

import UIKit

class StopWatchLabTableViewCell: UITableViewCell {
    @IBOutlet var lblLabName: UILabel!
    @IBOutlet var lblLabTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
