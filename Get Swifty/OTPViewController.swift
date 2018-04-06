//
//  OTPViewController.swift
//  Get Swifty
//
//  Created by Yousef At-tamimi on 4/6/18.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import Alamofire

class OTPViewController: UIViewController {

  
    var phoneNumber : String = ""

    @IBOutlet weak var codeEntered: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        sendVerification(phoneNumber: phoneNumber, code: codeEntered.text!)
        
    }
    
    func sendVerification(phoneNumber: String, code: String){
        
        let param : [String : String] = ["mobile":"+966\(phoneNumber)" , "code" : code]
        Alamofire.request("https://elmhackhub.com/api/v1/auth", method: .post, parameters: param).validate().responseJSON{
            response in
            
            switch response.result{
            case .success:
                if let JSON = response.result.value as? [String:Any]{
                    self.storeUserInfo(json: JSON)
                    self.performSegue(withIdentifier: "toSearchView", sender: self)
                }
                
            case .failure(let error):
                print(error)
                
                
            }
            
        }
    }
    
    func storeUserInfo(json : [String : Any]){
      
        let user = json["user"] as! [String : Any]
        let access_token = json["access_token"] as! String
        let user_id = user["user_id"] as! String
        let mobile = self.phoneNumber
        let name = user["full_name"] as! String

        let defaults = UserDefaults.standard
        defaults.set(access_token, forKey: "token")
        defaults.set(user_id, forKey: "user_id")
        defaults.set(mobile, forKey: "mobile")
        defaults.set(name, forKey: "name")
        
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
