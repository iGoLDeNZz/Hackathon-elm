//
//  EditProfileViewController.swift
//  Get Swifty
//
//  Created by Yousef At-tamimi on 4/7/18.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

//CHANGE THE IMAGE OF THE PROFILE

import UIKit
import Alamofire

class EditProfileViewController: UIViewController {

    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    var userId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         let defaults = UserDefaults.standard
        userId = defaults.string(forKey: "user_Id")!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayOnTextFields(userId: String){
        
        Alamofire.request("https://elmhackhub.com/api/v1/users/\(userId)").validate().responseJSON{
            response in
            
            switch response.result{
            case .success:
                if let JSON = response.result.value as? [String:Any]{
                   
                    print(JSON)
                    self.email.text = JSON["email"] as? String
                    self.fullName.text = JSON["full_name"] as? String
                    
                    //CHANGE THE IMAGE OF THE PROFILE
                    //CHANGE THE IMAGE OF THE PROFILE
                    //CHANGE THE IMAGE OF THE PROFILE
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func buttenPressed(_ sender: UIButton) {
        
    }
    
    func updateProfile(){
        
        //get user token from the local storage
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "access_token")
        
        //prepare the headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token ?? "")",
        ];

        
        let param : [String : String] = ["email":"\(email.text)" , "full_name" : "\(fullName.text)"]
        
        Alamofire.request("https://elmhackhub.com/api/v1/users/\(userId)", method: .put ,parameters: param, encoding: JSONEncoding.default, headers: headers).validate().responseJSON{
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
    
}
