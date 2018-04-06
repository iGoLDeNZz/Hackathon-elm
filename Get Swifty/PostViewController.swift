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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lat.text = "latitude: \(latitude)"
        long.text = "longitude: \(longitude)"
        quer.text = "Query: \(query)"
        
        let url : String = "https://elmhackhub.com/api/v1/posts?latitude=\(latitude)&longitude=\(longitude)&status_id=0&radius_km=5&metadata_key=Pup_\(query)"

        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        print("token \(token)")
        //prepare the headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        getPosts(URL: url, headers: headers)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getPosts(URL : String, headers : HTTPHeaders){
        
        Alamofire.request(URL , method: .get, headers: headers).validate().responseJSON{
            response in

            switch response.result{
            case .success:
                
                if let JSON = response.result.value as? [String:Any]{
                    print(JSON);
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
