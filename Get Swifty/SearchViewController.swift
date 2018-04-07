//
//  SearchViewController.swift
//  Get Swifty
//
//  Created by Rayan Aldafas on 06/04/2018.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation


class SearchViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var SearchTextField: UITextField!
    
    // location
    let locationManager = CLLocationManager()
    var longitude : Double = 0.0
    var latitude : Double = 0.0
    var postsArr : [post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    

    @IBAction func SearchButtonPressed(_ sender: Any) {
        SearchTextField.resignFirstResponder()
        savecoordinates()
        performSegue(withIdentifier: "toPosts", sender: self)
        
    }
    
    func savecoordinates(){
        
        let defaults = UserDefaults.standard
        defaults.set(latitude, forKey: "latitude")
        defaults.set(longitude, forKey: "longitude")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let posts = segue.destination as? PostsViewController {
            
            let url : String = "https://elmhackhub.com/api/v1/posts?latitude=\(latitude)&longitude=\(longitude)&status_id=0&radius_km=15&metadata_key=partner_\(SearchTextField.text!)"
            
            let defaults = UserDefaults.standard
            let token = defaults.string(forKey: "token")
            print("token \(token!)")
            //prepare the headers
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token!)",
                "Accept-Language" : "ar"
            ]
            
            getPosts(URL: url, headers: headers)
            posts.latitude = latitude
            posts.longitude = longitude
            posts.query = SearchTextField.text!
            let newPost = post(u: "286742378", p: "872647368", t: "rayan", d: "rayan rayan", n: "rayan", s: 1, tt: "Swift")
            self.postsArr.append(newPost)
            posts.posts = postsArr
            
            
        }
    }
    
    func getPosts(URL : String, headers : HTTPHeaders){
        let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(encodedUrl!)
        
        
        
        Alamofire.request(encodedUrl!, method: .get, headers: headers)
            .responseJSON { (response:DataResponse<Any>) in
                
                let data = response.data
                let jsonvalues = try? JSON(data: data!)
                
                var posts = jsonvalues!
                print ("posts: \(posts)")
                
                for var i in 0..<posts.count{
                    let title = posts[i]["metadata"]["title"].stringValue
                    let post_Id = posts[i]["post_id"].stringValue
                    let user = posts[i]["user"]
                    let user_id = user["user_id"].stringValue
                    let description = posts[i]["metadata"]["description"].stringValue
                    let name = posts[i]["user"]["full_name"].stringValue
                    let status = posts[i]["status_id"].intValue
                    
                    let newPost = post(u: user_id, p: post_Id, t: title, d: description, n: name, s: status)
                    self.postsArr.append(newPost)
                    print(self.postsArr.count)
                }
                print(self.postsArr.count)
                for post in self.postsArr {
                    print(post.user_id)
                }
                
                
        }
    }


}
