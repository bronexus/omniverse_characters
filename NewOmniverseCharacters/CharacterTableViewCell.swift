//
//  CharacterTableViewCell.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 11.10.2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    
    @IBOutlet var characterNameLabel: UILabel!
    @IBOutlet var lastLocationLabel: UILabel!
    @IBOutlet var characterEpisodeLabel: UILabel!
    @IBOutlet var characterImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
