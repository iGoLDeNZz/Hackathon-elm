//
//  SearchViewController.swift
//  Get Swifty
//
//  Created by Yousef At-tamimi on 4/6/18.
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
        self.navigationController?.isNavigationBarHidden = true

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
//        SearchTextField.resignFirstResponder()
        if SearchTextField.text == "" {
            return
        }
//        savecoordinates()
//        let defaults = UserDefaults.standard
//        let token = defaults.string(forKey: "token")
         let url : String = "https://elmhackhub.com/api/v1/posts?status_id=0&radius_km=15&metadata_key=partner_\(SearchTextField.text!)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer",
            "Accept-Language" : "ar"
        ]
         getPosts(URL: url, headers: headers)
        
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
            posts.latitude = latitude
            posts.longitude = longitude
            posts.query = SearchTextField.text!
            posts.posts = self.postsArr

        }
    }
    
    func getPosts(URL : String, headers : HTTPHeaders){
        let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        Alamofire.request(encodedUrl!, method: .get, headers: headers)
            .responseJSON { (response:DataResponse<Any>) in

                let data = response.data
                let jsonvalues = try? JSON(data: data!)

                if let posts = jsonvalues {
                self.postsArr = []
                for i in 0..<posts.count{
                    let title = posts[i]["metadata"]["title"].stringValue
                    let post_Id = posts[i]["post_id"].stringValue
                    let user = posts[i]["user"]
                    let user_id = user["user_id"].stringValue
                    let description = posts[i]["metadata"]["description"].stringValue
                    let name = posts[i]["user"]["full_name"].stringValue
                    let status = posts[i]["status_id"].intValue
                    let image = posts[i]["post_image"].stringValue

                    let newPost = post(u: user_id, p: post_Id, t: title, d: description, n: name, s: status, im: image)
                    self.postsArr.append(newPost)

                }
                }

        }
        // this is a hardcoded posts, the elm API dosen't return any results now :(.

        let title = "STC"
        let post_Id = "99"
        let user_id = "1"
        let description = "hello there!"
        let name = "Yousef almassad"
        let status = 1
        let image = "https://i.imgur.com/XiPY5FN.jpg"
        
        let newPost = post(u: user_id, p: post_Id, t: title, d: description, n: name, s: status, im: image)
        self.postsArr.append(newPost)

            performSegue(withIdentifier: "toPosts", sender: self)

    }


}
