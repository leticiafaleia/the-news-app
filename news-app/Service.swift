//
//  Service.swift
//  news-app
//
//  Created by Letícia Faleia on 15/05/25.
//

import Foundation

final class Service {
    
    static let shared = Service()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=f0226cdda92246adbd544845068c17b8")
    }
    
    private init() { }
       
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let result = try JSONDecoder().decode(APIStruct.self, from: data)
                        completion(.success(result.articles))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
}
