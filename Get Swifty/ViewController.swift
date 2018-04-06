//
//  ViewController.swift
//  Get Swifty
//
//  Created by Yousef At-tamimi on 4/6/18.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

   
    @IBOutlet weak var phoneNum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserAlreadyAuthed()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func checkIfUserAlreadyAuthed(){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        print(token)
        if token != nil {
            self.performSegue(withIdentifier: "toSearch", sender: self)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let param : [String : String] = ["mobile":"+966\(phoneNum.text!)"]
        login(phoneNumber: param)
    }
    
    
    func login(phoneNumber : [String:String]){
        
        Alamofire.request("https://elmhackhub.com/api/v1/users", method: .post, parameters: phoneNumber).validate().responseJSON{
        response in
            
            print("in func login")
            switch response.result{
                case .success:
                   
                    if let JSON = response.result.value as? [String:Any]{
                        print(JSON);
                        let res = JSON["success"]!
                        print(res)
                        self.performSegue(withIdentifier: "OTPView", sender: self)
                }
                
                case .failure(let error):
                    print(error)

                
            }
          
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearch" {
            
        }
       else if let OTP = segue.destination as? OTPViewController {
            OTP.phoneNumber = phoneNum.text!
        }
    }
    

}

