//
//  CharacterDetailsViewController.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 11.10.2021.
//

import UIKit

class CharacterDetailsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var characterDetailsNameLabel: UILabel!
    @IBOutlet var characterDetailsImage: UIImageView!
    @IBOutlet var characterDetailsLocationLabel: UILabel!
    @IBOutlet var characterDetailsEpisodeLabel: UILabel!
    @IBOutlet var characterDetailsStatusLabel: UILabel!
    
    @IBOutlet var alsoFromLocationLabel: UILabel!
    @IBOutlet var episodeCharactersTableView: UITableView!
    
    
    var receivedCharacterDetails: SingleCharacter?
    var characterDetails: SingleCharacter?
    
    var residentsUrls = [String]()
    var charactersOfLocation = [SingleCharacter]()
    
    var limitResidentsInList: Int = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()

        characterDetails = receivedCharacterDetails
        
        // Display selected character details from previous view
        characterDetailsNameLabel.text = characterDetails?.name
        characterDetailsLocationLabel.text = characterDetails?.location.name
        characterDetailsEpisodeLabel.text = characterDetails?.episode[0]
        characterDetailsStatusLabel.text = characterDetails?.status
        
        // Display episode details
        alsoFromLocationLabel.text = characterDetails?.location.name
        
        downloadLocationCharactersUrlListByEpisodeURL(urlString: (characterDetails?.location.url)!)
        
    }
    

    // MARK: - Episode Characters
    
    // Define number of rows in Episode Characters Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersOfLocation.count
    }

    // Define cell/s for Characters Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "residentCell") as? ResidentTableViewCell else { return UITableViewCell() }

        cell.residentNameLabel.text = charactersOfLocation[indexPath.row].name
        cell.residentLocationLabel.text = charactersOfLocation[indexPath.row].location.name
        cell.residentLocationLabel.text = charactersOfLocation[indexPath.row].episode[0]

        if let imageURL = URL(string: charactersOfLocation[indexPath.row].image) {
            DispatchQueue.global().async{
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.residentImage.image = image
                    }
                }
            }

        }
        return cell
    }
    
    // MARK: - Download Functions
    
    func downloadLocationCharactersUrlListByEpisodeURL(urlString: String) {
        let downloadURL = URL(string: urlString)
        guard let url = downloadURL else { return }
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data, urlResponse != nil, error == nil else {
                print("Location download Error.")
                return
            }
            print("Location download Succes.")
            do {
                let decoder = JSONDecoder()
                let locationResponse = try decoder.decode(Location.self, from: data)
                print("Loaded location \(urlString) of 108")
                print("Teleported to \(locationResponse.name).")
                
//                self.charactersList = characterResponse.results
                self.residentsUrls = locationResponse.residents
                
                for resident in 0...(self.residentsUrls.count - 1) where resident < self.limitResidentsInList {
                    self.downloadOneCharacter(urlString: self.residentsUrls[resident])
                }
                
                DispatchQueue.main.async {
//                    print(self.residentsUrls)
                    print(self.charactersOfLocation)
                    self.episodeCharactersTableView.reloadData()
                }
            } catch {
                print("Location decode Error.")
            }
            
        }.resume()
    }
    
    func downloadOneCharacter(urlString: String) {
        let downloadURL = URL(string: urlString)
        guard let url = downloadURL else { return }
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data, urlResponse != nil, error == nil else {
                print("Character download Error.")
                return
            }
//            print("Character download Succes.")
            do {
                let decoder = JSONDecoder()
                let oneCharacter = try decoder.decode(SingleCharacter.self, from: data)
//                print("Loaded character \(urlString)")
                
                self.charactersOfLocation.append(oneCharacter)
                DispatchQueue.main.async {
                    self.episodeCharactersTableView.reloadData()
                }
            } catch {
                print("Character decode Error.")
            }
            
        }.resume()
    }
    
}
