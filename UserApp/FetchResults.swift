//
//  FetchResults.swift
//  UserApp
//
//  Created by Mac on 19/07/23.
//

import UIKit
import CoreData
import Kingfisher

class FetchResults: UIViewController, NSFetchedResultsControllerDelegate {
    var fetchController : NSFetchedResultsController<Articles>?
    var articles: [MyArticle] = []
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        //MARK: Core Data
        //        let context = VMClass().context
        //        let fetchRequest: NSFetchRequest<Articles> = Articles.fetchRequest()
        //
        //        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        //        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //        fetchController = NSFetchedResultsController(
        //            fetchRequest: fetchRequest,
        //            managedObjectContext: context,
        //            sectionNameKeyPath: nil,
        //            cacheName: nil
        //        )
        //        fetchController?.delegate = self
        
        //        do {
        //            try fetchController?.performFetch()
        //        } catch {
        //            print("Error fetching data: \(error)")
        //        }
        //        saveJsonData()
        urlSessionExample()
    }
    
    func saveJsonData() {
        
        
        
        
        //MARK: coeded
        //        let decoder = JSONDecoder()
        //        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
        //            do {
        //                let data = try Data(contentsOf: URL(fileURLWithPath: path))
        //                let myart = try decoder.decode(Arts.self, from: data)
        //                articles = myart.articles
        //                print(articles[0].url)
        //            } catch {
        //                print("\(error)")
        //            }
        
        //MARK: json serialization
        
        //            do {
        //                let data = try Data(contentsOf: URL(fileURLWithPath: path))
        //                if let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary{
        //                    if let jsonArray = jsonObj.value(forKey: "articles") as? NSArray {
        //
        //                        let helperObj = VMClass()
        //                        for a in jsonArray {
        //                            if let a = a as? NSDictionary{
        //                                var article = MyArticle()
        //                                article.title = a.value(forKey: "title") as? String ?? ""
        //                                article.publishedAt = a.value(forKey: "publishedAt") as? String ?? ""
        //                                article.artDesc = a.value(forKey: "description") as? String ?? ""
        //                                article.content = a.value(forKey: "content") as? String ?? ""
        //                                article.urlToImage = a.value(forKey: "urlToImage") as? String ?? ""
        //                                article.author = a.value(forKey: "author") as? String ?? ""
        //                                articles.append(article)
        //                            }
        //                        }
        //                    }
        //                } else {
        //                    print("json empty")
        //                }
        //            } catch {
        //                print("Error reading JSON file: \(error)")
        //            }
        //        }
    }
    //MARK: Url Session
    func urlSessionExample() {
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-06-21&sortBy=publishedAt&apiKey=cd19a89dd229476998dd1c422eed946e")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            if let error = error {
                print("error in task")
                return
            }
            if let jdata = data {
                do {
                    let decoder = JSONDecoder()
                    let arts = try decoder.decode(Arts.self, from: jdata)
                    self.articles = arts.articles
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                } catch {
                    print("error in conversion")
                }
            }
        })
        task.resume()
    }
}
extension FetchResults: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleCell
        cell.selectionStyle = .none
        let item = articles[indexPath.row]//fetchController?.object(at: indexPath)
        cell.backgroundColor = .cyan
        cell.myLbl.text = item.title
        let url = URL(string: item.urlToImage ?? "www.example.com")
        
        let processor = DownsamplingImageProcessor(size: cell.articleImage.frame.size)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.articleImage?.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "person"),
            options: [
                //                .processor(processor)
            ]
        )
        cell.articleImage.layer.cornerRadius = 150
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count//fetchController?.fetchedObjects?.count ?? 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


