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
        
        
//        let url : String = "https://elmhackhub.com/api/v1/posts?latitude=\(latitude)&longitude=\(longitude)&status_id=0&radius_km=15&metadata_key=partner_\(query)"
//
//        let defaults = UserDefaults.standard
//        let token = defaults.string(forKey: "token")
//        print("token \(token!)")
//        //prepare the headers
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(token!)",
//            "Accept-Language" : "ar"
//        ]
//
//        getPosts(URL: url, headers: headers)
    }
    
    func getPosts(URL : String, headers : HTTPHeaders){
        let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(encodedUrl!)


        
        Alamofire.request(encodedUrl!, method: .get, headers: headers)
            .responseJSON { (response:DataResponse<Any>) in
                
                let data = response.data
                let jsonvalues = try? JSON(data: data!)

                var postsFromJson = jsonvalues!
                print("posts in postViewController: \(postsFromJson)")
                
                for var i in 0..<postsFromJson.count{
                    let title = postsFromJson[i]["metadata"]["title"].stringValue
                    let post_Id = postsFromJson[i]["post_id"].stringValue
                    let user = postsFromJson[i]["user"]
                    let user_id = user["user_id"].stringValue
                    let description = postsFromJson[i]["metadata"]["description"].stringValue
                    let name = postsFromJson[i]["user"]["full_name"].stringValue
                    let status = postsFromJson[i]["status_id"].intValue

                    let newPost = post(u: user_id, p: post_Id, t: title, d: description, n: name, s: status)
                    self.posts.append(newPost)
                    print(self.posts.count)
                }
                print(self.posts.count)
                for post in self.posts {
                    print(post.user_id)
                }

                
        }
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
        
        print(posts[indexPath.row].title)
        print(cell.postTitleLabel.text)
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


