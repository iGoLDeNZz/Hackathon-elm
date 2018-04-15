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

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mobilePhoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mobilePhoneTextField.layer.borderColor = UIColor.white.cgColor
        mobilePhoneTextField.layer.borderWidth = 1.0
        mobilePhoneTextField.setLeftPaddingPoints(75)
        
        // backend
        checkIfUserAlreadyAuthed()
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func SendPINButtonPressed(_ sender: Any) {
        mobilePhoneTextField.resignFirstResponder()
        let param : [String : String] = ["mobile":"+966\(mobilePhoneTextField.text!)"]
        login(phoneNumber: param)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
    }
    
    func checkIfUserAlreadyAuthed(){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
//        print("token: "+token?)
        if token != nil {
            self.performSegue(withIdentifier: "toSearch", sender: self)
        }
        else{
            print("no token")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    
    
    func login(phoneNumber : [String:String]){
        
        Alamofire.request("https://elmhackhub.com/api/v1/users", method: .post, parameters: phoneNumber).validate().responseJSON{
            response in
            
            switch response.result{
            case .success:
                if let JSON = response.result.value as? [String:Any]{
                    print(JSON);
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
            OTP.phoneNumber = mobilePhoneTextField.text!
        }
    }

}



