//
//  NewsTableViewCell.swift
//  news-app
//
//  Created by Letícia Faleia on 16/05/25.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let newsSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSubtitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsImageView.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        newsTitleLabel.frame = CGRect(x: 100, y: 3, width: contentView.frame.size.width - 110, height: 30)
        newsSubtitleLabel.frame = CGRect(x: 100, y: 33, width: contentView.frame.size.width - 110, height: 60)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        newsTitleLabel.text = nil
        newsSubtitleLabel.text = nil
    }
    
    func configure(with viewModel: NewsViewModel) {
        newsTitleLabel.text = viewModel.title
        newsSubtitleLabel.text = viewModel.subtitle
        
        // Limpa imagem antiga
        newsImageView.image = nil
        
        // Verifica se já tem a imagem em cache
        if let data = viewModel.imageData {
            self.newsImageView.image = UIImage(data: data)
        }
        // Se não tiver, tenta baixar
        else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, let data = data, error == nil else {
                    print("❌ Erro ao baixar imagem:", error ?? NSError())
                    return
                }
                
                // Atualiza o ViewModel
                viewModel.imageData = data
                
                // Atualiza a imagem na main thread
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
