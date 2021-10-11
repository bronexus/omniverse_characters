//
//  MainViewController.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 11.10.2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var charactersTableView: UITableView!
    
    var charactersList = [SingleCharacter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateCharactersListByPageURL(urlString: "https://rickandmortyapi.com/api/character")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UITableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersList.count
    }
    
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
    
    
    // MARK: - Download Functions
    
    func updateCharactersListByPageURL(urlString: String) {
        let downloadURL = URL(string: urlString)
        guard let url = downloadURL else { return }
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data, urlResponse != nil, error == nil else {
                print("Character download Error")
                return
            }
            print("Character download Succes")
            do {
                let decoder = JSONDecoder()
                let characterResponse = try decoder.decode(CharacterPageResponse.self, from: data)
                print("\(characterResponse.results[0].name) is online")
                self.charactersList = characterResponse.results
                DispatchQueue.main.async {
                    self.charactersTableView.reloadData()
                }
            } catch {
                print("Decode Error")
            }
            
        }.resume()
    }
    
    
}
