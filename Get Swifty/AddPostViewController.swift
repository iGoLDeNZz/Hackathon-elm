//
//  AddPostViewController.swift
//  Get Swifty
//
//  Created by Yousef At-tamimi on 4/7/18.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import Alamofire

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var keyword: UITextField!
    @IBOutlet weak var Description: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        addPost()
    }
    
    func addPost(){
        //get user token and location from the local storage
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let latitude = defaults.double(forKey: "latitude")
        let longitude = defaults.double(forKey: "longitude")
        //prepare the headers
        
        let headers: HTTPHeaders = [
            "Authorization": "bearer \(token!)",
            "Content-Type": "application/json"
        ];
        
        let metaData: [String: Any] = ["title": postTitle.text!, "description": Description.text!]

        
        let params:  [String : Any] =   ["latitude": latitude , "longitude": longitude ,
                                         "metadata_key": "partner_\(keyword.text ?? "swift")",  "metadata": metaData]
        
        let URL = "https://elmhackhub.com/api/v1/posts";
        let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
        Alamofire.request(encodedUrl!, method: .post, parameters:params, encoding: JSONEncoding.default, headers: headers).responseJSON{
            response in
            switch response.result{
            case .success:
                print("in success")
                if let JSON = response.result.value {
                    print("heey")
                    print(JSON);
                    debugPrint(params)
                }
                
            case .failure(let error):
                print("in failure")
                //print(error)
                //debugPrint(response)
                print(params)
                print(headers)
                
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
