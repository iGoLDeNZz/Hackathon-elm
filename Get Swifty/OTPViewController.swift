//
//  OTPViewController.swift
//  Get Swifty
//
//  Created by Rayan Aldafas on 06/04/2018.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import Alamofire

class OTPViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var PINCodeTextField: UITextField!
    var phoneNumber : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        PINCodeTextField.layer.borderColor = UIColor.white.cgColor
        
        PINCodeTextField.layer.borderWidth = 1.0
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        PINCodeTextField.resignFirstResponder()
        sendVerification(phoneNumber: phoneNumber, code: PINCodeTextField.text!)
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

}
