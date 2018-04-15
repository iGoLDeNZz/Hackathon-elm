//
//  ProfileViewController.swift
//  Get Swifty
//
//  Created by Yousef At-tamimi on 4/7/18.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import Alamofire


class ProfileViewController: UIViewController {

    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var profileDescription: UITextView!
    @IBOutlet weak var profilePhone: UITextField!
    @IBOutlet weak var profileEmail: UITextField!
    @IBOutlet weak var profileTags: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var upperView: UIView!
    
    var user_id : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        profileImage.layer.cornerRadius = 55
        profileImage.clipsToBounds = true
        self.view.sendSubview(toBack: upperView)

        
        findUserDetails()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func findUserDetails(){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept-Language" : "ar"
        ]
        
        let URL = "https://elmhackhub.com/api/v1/users/\(user_id)"
        
        let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(encodedUrl!)
        
        Alamofire.request(encodedUrl!, headers: headers)
            .responseJSON { (response:DataResponse<Any>) in
            
            switch response.result{
            case .success:
                if let JSON = response.result.value as? [String:Any]{
                    // print(JSON)
                    print(JSON)
                    self.fillUpUserDetails(json: JSON)
                    
                    
                }
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func fillUpUserDetails(json : [String : Any]){
        
        profileEmail.text = (json["email"] as! String)
        profileName.text = (json["full_name"] as! String)
        profilePhone.text = (json["mobile"] as! String)
        profileDescription.text = "وصف شخصي للملف"
        profileTags.text = "رياضة، علم، صحة، قهوة"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        //get user token from the local storage
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let user_id = defaults.string(forKey: "user_id")
        let full_name = self.profileName.text
        let email = self.profileEmail.text
        let mobile = self.profilePhone.text
        
        //prepare the headers
        let headers: HTTPHeaders = [
            "Authorization": "bearer \(token!)",
            "Content-Type": "application/json"
        ];
        print(headers)
        let params:  [String : Any] =   ["user_id": user_id! , "full_name": full_name! ,
                                         "mobile": mobile!,  "email": email!, "email_activated": false, "mobile_activated": true]
        
        let URL = "https://elmhackhub.com/api/v1/users/\(user_id!)";
        let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        Alamofire.request(encodedUrl!, method: .put, parameters:params, headers: headers).responseJSON{
            response in
            switch response.result{
            case .success:
                print("in success")
                if let JSON = response.result.value {
                    debugPrint(JSON)
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
