//
//  MainViewController.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 11.10.2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var charactersTableView: UITableView!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var pageNumberLabel: UILabel!
    
    var charactersList = [SingleCharacter]()
    var nextPage = String()
    var prevPage = String()
    var pageCounter: Int = 1
    var characterEpisodeName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.charactersTableView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        // Fetch to charactersList variable Characters if first page of Rick and Morty API
        downloadCharactersListByPageURL(urlString: "https://rickandmortyapi.com/api/character")
        
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
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
        
        if let episodeURL = URL(string: charactersList[indexPath.row].episode[0]) {
            DispatchQueue.global().async {
                URLSession.shared.dataTask(with: episodeURL) { data, urlRepsonse, error in
                    guard let data = data, urlRepsonse != nil, error == nil else {
                        print("Episode download Error.")
                        self.characterEpisodeName = self.charactersList[indexPath.row].episode[0]
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let episode = try decoder.decode(Episode.self, from: data)
                        self.characterEpisodeName = episode.name
                    } catch {
                        print("Episode download error.")
                    }
                }.resume()
            }
        }
        
        cell.characterEpisodeLabel.text = characterEpisodeName
        cell.characterImage.loadThumbnail(urlSting: self.charactersList[indexPath.row].image)
        
        return cell
    }
    
    // MARK: - Interaction with UITableView
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCharacterDetails", sender: self)
        charactersTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterDetailsViewController {
            destination.receivedCharacterDetails = charactersList[(charactersTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    // MARK: - Buttons
    
    @IBAction func prevButton(_ sender: Any) {
        if self.prevPage != "", pageCounter > 1 {
            downloadCharactersListByPageURL(urlString: self.prevPage)
            pageCounter -= 1
            pageNumberLabel.text = "Page \(pageCounter)/34"
            self.nextButton.isHidden = false
        } else { prevButton.isHidden = true}
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if self.nextPage != "", pageCounter < 34 {
            downloadCharactersListByPageURL(urlString: self.nextPage)
            pageCounter += 1
            pageNumberLabel.text = "Page \(pageCounter)/34"
            self.prevButton.isHidden = false
        } else { nextButton.isHidden = true}
    }
    
    
    // MARK: - Download Functions
    
    // Fetch Characters to charactersList variable
    func downloadCharactersListByPageURL(urlString: String) {
        let downloadURL = URL(string: urlString)
        guard let url = downloadURL else { return }
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data, urlResponse != nil, error == nil else {
                print("Characters Page download Error.")
                return
            }
            print("Characters Page download Succes.")
            do {
                let decoder = JSONDecoder()
                let characterResponse = try decoder.decode(CharacterPageResponse.self, from: data)
                print("Loaded characters page \(urlString) of 34.")
                print("\(characterResponse.results[0].name) is online.")
                
                if characterResponse.info.next != nil {
                    self.nextPage = characterResponse.info.next!
                }
                if characterResponse.info.prev != nil {
                    self.prevPage = characterResponse.info.prev!
                }
                
                self.charactersList = characterResponse.results
                DispatchQueue.main.async {
                    self.charactersTableView.reloadData()
                }
            } catch {
                print("Characters page decode Error.")
            }
        }.resume()
    }

    
}
