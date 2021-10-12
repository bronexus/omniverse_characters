//
//  CharacterDetailsViewController.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 11.10.2021.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    @IBOutlet var characterDetailsNameLabel: UILabel!
    @IBOutlet var characterDetailsImage: UIImageView!
    @IBOutlet var characterDetailsLocationLabel: UILabel!
    @IBOutlet var characterDetailsEpisodeLabel: UILabel!
    @IBOutlet var characterDetailsStatusLabel: UILabel!
    
    
    var receivedCharacterDetails: SingleCharacter?
    var characterDetails: SingleCharacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        characterDetails = receivedCharacterDetails
        
        // Display selected character details from previous view
        characterDetailsNameLabel.text = characterDetails?.name
        characterDetailsLocationLabel.text = characterDetails?.location.name
        characterDetailsEpisodeLabel.text = characterDetails?.episode[0]
        characterDetailsStatusLabel.text = characterDetails?.status
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
