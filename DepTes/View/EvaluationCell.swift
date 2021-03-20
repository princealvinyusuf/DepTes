//
//  MessageCell.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 20/03/21.
//

import UIKit

class EvaluationCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var redDepression: UIImageView!
    @IBOutlet weak var orangeDepression: UIImageView!
    @IBOutlet weak var yellowDepression: UIImageView!
    @IBOutlet weak var greenDepression: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}
