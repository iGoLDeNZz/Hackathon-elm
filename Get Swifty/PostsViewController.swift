//
//  PostsViewController.swift
//  Get Swifty
//
//  Created by Rayan Aldafas on 07/04/2018.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var query : String = ""
    var posts : [post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.separatorColor = UIColor(white: 1, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts)
        return posts.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        cell.postTitleLabel.text = posts[indexPath.row].title
        cell.postDescriptionTextView.text = posts[indexPath.row].description
        cell.postTagLabel.text = posts[indexPath.row].tag ?? "swift"
        cell.postImage.downloadedFrom(link: posts[indexPath.row].image!)
        cell.contentView.backgroundColor = UIColor(white: 1, alpha: 1)
        cell.selectionStyle = .none
        
        return cell
    }
    
  
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
            self.posts.removeAll()
            tableView.reloadData()
        }
    }
    
    
}


