//
//  UrlImageView.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 12.10.2021.
//

import Foundation
import SwiftUI

struct UrlImageView {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
//    var body: some View {
//        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
//            .resizable()
//            .scaledToFit()
//            .frame(width: 100, height: 100)
//    }
//
//    static var defaultImage = UIImage(named: "NewsIcon")
}
