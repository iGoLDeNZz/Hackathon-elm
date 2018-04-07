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

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var tagsOfInterests: UILabel!
    @IBOutlet weak var UserBio: UILabel!
    
    var user_id : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         let URL = "https://elmhackhub.com/api/v1/users/\(user_id)"
        findUserDetails(url: URL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
       
        // Dispose of any resources that can be recreated.
    }
    
    func findUserDetails(url: String){
        
        Alamofire.request(url).validate().responseJSON{
            response in

            switch response.result{
            case .success:
                if let JSON = response.result.value as? [String:Any]{
                   // print(JSON)
                    self.fillUpUserDetails(json: JSON)

                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func fillUpUserDetails(json : [String : Any]){
        
        self.email.text = json["email"] as? String
        self.name.text = json["full_name"] as? String
        self.UserBio.text = "This is a bio field that is suppose to be provided by the back-end"

        //Image
        let imageUrlString = json["url"] as? String
        let imageUrl = URL(string: imageUrlString!)
        let imageData = try! Data(contentsOf: imageUrl!)
        let image = UIImage(data: imageData)
        self.userImage.image = image
        
        self.tagsOfInterests.text = "Swift, Coffee, Reading, Poetry, Hiking."
        
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
