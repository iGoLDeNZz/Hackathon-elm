//
//  PostViewController.swift
//  Get Swifty
//
//  Created by Yousef At-tamimi on 4/6/18.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class PostViewController: UIViewController {

    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var quer: UILabel!
    @IBOutlet weak var long: UILabel!
    
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var query : String = ""
    var posts : [post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lat.text = "latitude: \(latitude)"
        long.text = "longitude: \(longitude)"
        quer.text = "Query: \(query)"
        
        let url : String = "https://elmhackhub.com/api/v1/posts?latitude=\(latitude)&longitude=\(longitude)&status_id=0&radius_km=15&metadata_key=partner_\(query)"

        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        print("token \(token!)")
        //prepare the headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept-Language" : "ar"
        ]
        
        getPosts(URL: url, headers: headers)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getPosts(URL : String, headers : HTTPHeaders){
        let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(encodedUrl!)


        
        Alamofire.request(encodedUrl!, method: .get, headers: headers)
            .responseJSON { (response:DataResponse<Any>) in
                
                let data = response.data
                let jsonvalues = try? JSON(data: data!)
                
                var posts = jsonvalues!
                
                for var i in 0..<posts.count{
                    let title = posts[i]["metadata"]["title"].stringValue
                    let post_Id = posts[i]["post_id"].stringValue
                    let user = posts[i]["user"]
                    let user_id = user["user_id"].stringValue
                    let description = posts[i]["metadata"]["description"].stringValue
                    let name = posts[i]["user"]["full_name"].stringValue
                    let status = posts[i]["status_id"].intValue
                    
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
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        //DONT FORGET TO PASS USER ID THAT OWNS THE PICTURE TO BE ABLE TO LOAD HIS PICTURE
        
        performSegue(withIdentifier: "toUserProfile", sender: self)
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let userProfile = segue.destination as? ProfileViewController {
           // userProfile.user_id = (String)sender.tag as UIButton
            //UP THERE YOU SHOULD CHANGE THE USER ID ATTRIBUTE FOR THE USERPROFILE VIEW
        }
        
    }

}
