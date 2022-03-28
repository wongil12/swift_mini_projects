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
                self.newsList = data
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

}

