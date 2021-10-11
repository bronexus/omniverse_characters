//
//  CharacterTableViewCell.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 11.10.2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    
    @IBOutlet var characterCellView: UIView!
    @IBOutlet var characterNameLabel: UILabel!
    @IBOutlet var lastLocationLabel: UILabel!
    @IBOutlet var characterEpisodeLabel: UILabel!
    @IBOutlet var characterImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        characterCellView.layer.shadowColor = UIColor.black.cgColor
        characterCellView.layer.shadowOpacity = 0.2
        characterCellView.layer.shadowOffset = .zero
        characterCellView.layer.shadowRadius = 5
        
        characterCellView.layer.cornerRadius = 10
        characterImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
