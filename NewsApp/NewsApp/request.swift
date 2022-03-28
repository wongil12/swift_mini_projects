//
//  request.swift
//  NewsApp
//
//  Created by Wongil on 2022/03/28.
//

import UIKit

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let author: String
    let title: String
    let description: String
    let url: String
    let publishedAt: String
}

func requestNewsList(_ url: URL, completion: @escaping([Article]?) -> ()) {
//    print(url)
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) {
        (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
            completion(nil)
        } else if let data = data {
            let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
            
            if let articleList = articleList {
                completion(articleList.articles)
            }
        }
    }.resume()
}
