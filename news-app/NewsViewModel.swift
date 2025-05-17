//
//  NewsViewModel.swift
//  news-app
//
//  Created by Letícia Faleia on 16/05/25.
//

import Foundation
import UIKit

class NewsViewModel {
    let title: String
    let subtitle: String
    let imageUrl: URL?
    var imageData: Data?
    
    init(title: String, subtitle: String, imageUrl: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
        self.imageData = nil
    }
}
