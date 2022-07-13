//
//  NewsTableViewController.swift
//  ImageLoadingURL
//
//  Created by linto jacob on 13/07/22.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var dataModel: [Articles]?
    override func viewDidLoad() {
        super.viewDidLoad()
        APIHandler()
      
    }
    func APIHandler() {
        let session = URLSession.shared
                let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&from=2022-06-13&sortBy=publishedAt&apiKey=5dacfe357b8e482e8f7ebe64d520e76e&page=1")!
                let task = session.dataTask(with: url, completionHandler: { data, response, error in
                    // Check the response
                    print(response)

                    // Check if an error occured
                    if error != nil {
                        // HERE you can manage the error
                        print(error.debugDescription)
                        return
                    }

                    // Serialize the data into an object
                    do {
                        let json = try JSONDecoder().decode(NewsModel.self, from: data! )
                        print(json)
                        self.dataModel = json.articles
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Error during JSON serialization: \(error.localizedDescription)")
                    }

                })
                task.resume()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let article = self.dataModel?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.title.text = article.title
        cell.loadImage(url: article.urlToImage ?? "")
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
