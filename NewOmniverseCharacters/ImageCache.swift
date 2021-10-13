//
//  ImageCache.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 13.10.2021.
//

import Foundation
import UIKit

public enum Result<T> {
    case success(T)
    case failure(Error)
}

final class Networking: NSObject {
    private static func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public static func downloadImage(url: URL, completion: @escaping (Result<Data>) -> Void) {
        Networking.getData(url: url) { data, urlResponde, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, error != nil else {
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadThumbnail(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        Networking.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                self.image = UIImage(data: data)
            case .failure(_):
                self.image = UIImage(named: "noImage")
            }
        }
    }
}
