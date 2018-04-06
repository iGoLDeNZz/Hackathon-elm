//
//  AddPostViewController.swift
//  Get Swifty
//
//  Created by YOUSEF ALKHALIFAH on 20/07/1439 AH.
//  Copyright © 1439 Yousef At-tamimi. All rights reserved.
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
        ]
        
        let parameters =  ["latitude": 46.668108, "longitude": 24.75608, "metadata_key": "Pup_\(keyword.text)"] as [String : Any]
        
        Alamofire.request("https://elmhackhub.com/api/v1/posts", method: .post, headers: headers, parameters: parameters).validate().responseJSON{
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
