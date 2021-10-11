//
//  MainViewController.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 11.10.2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var charactersTableView: UITableView!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var pageNumberLabel: UILabel!
    
    var charactersList = [SingleCharacter]()
    var nextPage = String()
    var prevPage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch to charactersList variable Characters if first page of Rick and Morty API
        downloadCharactersListByPageURL(urlString: "https://rickandmortyapi.com/api/character")
    }
    

    // MARK: - UITableView Functions
    
    // Define number of rows in Characters Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersList.count
    }
    
    // Define cell/s for Characters Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as? CharacterTableViewCell else { return UITableViewCell() }
        
        cell.characterNameLabel.text = charactersList[indexPath.row].name
        cell.lastLocationLabel.text = charactersList[indexPath.row].location.name
        cell.characterEpisodeLabel.text = charactersList[indexPath.row].episode[0]
        
        if let imageURL = URL(string: charactersList[indexPath.row].image) {
            DispatchQueue.global().async{
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.characterImage.image = image
                    }
                }
            }

        }
        return cell
    }
    
    
    
    // MARK: - Buttons
    
    @IBAction func prevButton(_ sender: Any) {
        if self.prevPage != "" {
            downloadCharactersListByPageURL(urlString: self.prevPage)
        } else { prevButton.isHidden = false}
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if self.nextPage != "" {
            downloadCharactersListByPageURL(urlString: self.nextPage)
        } else { nextButton.isHidden = false}
    }
    
    
    // MARK: - Download Functions
    
    // Fetch Characters to charactersList variable
    func downloadCharactersListByPageURL(urlString: String) {
        let downloadURL = URL(string: urlString)
        guard let url = downloadURL else { return }
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data, urlResponse != nil, error == nil else {
                print("Character download Error.")
                return
            }
            print("Character download Succes.")
            do {
                let decoder = JSONDecoder()
                let characterResponse = try decoder.decode(CharacterPageResponse.self, from: data)
                print("Loaded page \(urlString) of 34.")
                print("\(characterResponse.results[0].name) is online.")
                guard let nextPage = characterResponse.info.next else { return }
                self.nextPage = nextPage
                guard let prevPage = characterResponse.info.next else { return }
                self.prevPage = prevPage
                self.charactersList = characterResponse.results
                DispatchQueue.main.async {
                    self.charactersTableView.reloadData()
                }
            } catch {
                print("Decode Error.")
            }
            
        }.resume()
    }
    
    
}
