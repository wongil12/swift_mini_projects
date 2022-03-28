//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Wongil on 2022/03/28.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    // 뉴스 순번 Label
    @IBOutlet var lblIndex: UILabel!
    // 뉴스 제목 Label
    @IBOutlet var lblTitle: UILabel!
    // 뉴스 날짜 시간 Label
    @IBOutlet var lblDateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
