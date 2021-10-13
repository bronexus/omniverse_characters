//
//  ResidentTableViewCell.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 12.10.2021.
//

import UIKit

class ResidentTableViewCell: UITableViewCell {

    @IBOutlet var residentViewCell: UIView!
    @IBOutlet var residentNameLabel: UILabel!
    @IBOutlet var residentLocationLabel: UILabel!
    @IBOutlet var residentEpisodeLabel: UILabel!
    @IBOutlet var residentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        residentViewCell.layer.shadowColor = UIColor.black.cgColor
        residentViewCell.layer.shadowOpacity = 0.2
        residentViewCell.layer.shadowOffset = .zero
        residentViewCell.layer.shadowRadius = 5
        
        residentViewCell.layer.cornerRadius = 10
        residentImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
