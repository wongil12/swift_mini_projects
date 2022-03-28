//
//  ViewController.swift
//  NewsApp
//
//  Created by Wongil on 2022/03/28.
//

import UIKit

class ViewController: UIViewController,  UITableViewDataSource {
    
    @IBOutlet var tblNews: UITableView!
    
    var newsList = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=015a7046d12049ec84b2fc11e24db497")!
        requestNewsList(url) {
            (data) in
            if let data = data {
                
                // 날짜 비교할 오늘 날짜 구하고 포매터 만들기
                let nowDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "hh:mm"
                
                let nowDateStr = dateFormatter.string(from: nowDate)
                
                // publishedAt가 오늘 날짜이면 hh:mm으로 보이고 오늘이 아니면 yyyy-MM-dd로 보이게
                self.newsList = data.map({(newsData: Article) -> Article in
                    var newArticle = newsData
                    let pubDate = self.toDate(newArticle.publishedAt)!
                    let pubDateStr = dateFormatter.string(from: pubDate)
                    
                    if pubDateStr == nowDateStr {
                        let pubTimeStr = timeFormatter.string(from: pubDate)
                        newArticle.publishedAt = pubTimeStr
                    } else {
                        newArticle.publishedAt = pubDateStr
                    }
                    
                    return newArticle
                })
            }
            DispatchQueue.main.async {
                self.tblNews.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCell", for: indexPath) as! NewsTableViewCell
        
        cell.lblIndex.text = String(indexPath.row + 1)
        cell.lblTitle.text = self.newsList[indexPath.row].title
        cell.lblDateTime.text = self.newsList[indexPath.row].publishedAt
        
        return cell
    }
    
    // API에서 published 날짜를 yyyy-MM-dd'T'HH:mm:ss'Z'로 보내주는 것을 Date객체로 변환
    func toDate(_ string: String) -> Date? {
          
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter1.locale = Locale(identifier: "ko")
        
        guard let date2 = formatter1.date(from: string) else {
            return nil
        }
        return date2
    }

}

