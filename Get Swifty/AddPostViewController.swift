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
        
    }
    
    func addPost(){
        //get user token from the local storage
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "access_token")
        
        //prepare the headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token ?? "")",
            "Content-Type": "application/json"
        ];
        
        
        // let params: [String : Any] =  ["latitude": 46.668108, "longitude": 24.75608, "metadata_key": "Pup_\(keyword.text ?? "swift")"]
        let param : [String : String] = ["mobile":"+966" , "code" : "123"]
        
        Alamofire.request("https://elmhackhub.com/api/v1/posts", headers: headers, parameters: param, method: .post ).validate().responseJSON{
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


