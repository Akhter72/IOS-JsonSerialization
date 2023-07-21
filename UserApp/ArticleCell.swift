//
//  ArticleCell.swift
//  UserApp
//
//  Created by Mac on 19/07/23.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var myLbl: UILabel!
    
    @IBOutlet weak var articleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        self.selectionStyle = .none
        
    }
    
}
