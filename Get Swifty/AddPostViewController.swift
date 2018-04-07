//
//  AddPostViewController.swift
//  Get Swifty
//
//  Created by Rayan Aldafas on 07/04/2018.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import Alamofire

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var TagsTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var addPostButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage?
    var info: [String : Any] = [:]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // addPostButton border radius
        addPostButton.layer.cornerRadius = 3
        addPostButton.clipsToBounds = true
        
        // adding right padding
        TitleTextField.setRightPaddingPoints(10)
        TagsTextField.setRightPaddingPoints(10)
        DescriptionTextField.setRightPaddingPoints(10)
        
        // bottom border only
        let titleBorder = CALayer()
        let width = CGFloat(1.0)
        titleBorder.borderColor = UIColor.lightGray.cgColor
        titleBorder.frame = CGRect(x: 0, y: TitleTextField.frame.size.height - width, width:  TitleTextField.frame.size.width, height: TitleTextField.frame.size.height)
        titleBorder.borderWidth = width
        TitleTextField.layer.addSublayer(titleBorder)
        TitleTextField.layer.masksToBounds = true
        
        let tagsBorder = CALayer()
        tagsBorder.borderColor = UIColor.lightGray.cgColor
        tagsBorder.frame = CGRect(x: 0, y:
            TagsTextField.frame.size.height - width, width: TagsTextField.frame.size.width, height: TagsTextField.frame.size.height)
        tagsBorder.borderWidth = width
        TagsTextField.layer.addSublayer(tagsBorder)
        TagsTextField.layer.masksToBounds = true
        
        let descriptionBorder = CALayer()
        descriptionBorder.borderColor = UIColor.lightGray.cgColor
        descriptionBorder.frame = CGRect(x: 0, y:
            DescriptionTextField.frame.size.height - width, width: DescriptionTextField.frame.size.width, height: DescriptionTextField.frame.size.height)
        descriptionBorder.borderWidth = width
        DescriptionTextField.layer.addSublayer(descriptionBorder)
        DescriptionTextField.layer.masksToBounds = true
        
    }

<<<<<<< HEAD
    @IBAction func addPostButtonPressed(_ sender: Any) {
        addPost()
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
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
        
        let metaData: [String: Any] = ["title": TitleTextField.text!, "description": DescriptionTextField.text!]
        
        
        let params:  [String : Any] =   ["latitude": latitude , "longitude": longitude ,
                                         "metadata_key": "partner_\(TagsTextField.text ?? "swift")",  "metadata": metaData]
        
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
||||||| merged common ancestors
=======
    
>>>>>>> 68ac0a960b2ed898fe39b3edf989d4fb55c924da
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
    @IBAction func buttonPressed(_ sender: Any) {
        addPost()
    }
    func addPost(){
        //get user token from the local storage
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        //prepare the headers
        let headers: HTTPHeaders = [
            "Authorization": "bearer \(token!)",
            "Content-Type": "application/json"
        ];
        
        let metaData: [String: Any] = ["title": TitleTextField.text!, "description": DescriptionTextField.text!]
        
        
        
        //        let params: [String : Any] =  ["latitude": 24.75608, "longitude": 46.668108, "description": "5:00 pm",
        //                                       "metadata_key": "partner_\(keyword.text ?? "swift")"]
        let latitude = 24.75608
        let longitude = 46.668108
        let params:  [String : Any] =   ["latitude": latitude , "longitude": longitude ,
                                         "metadata_key": "partner_\(TagsTextField.text ?? "swift")",  "metadata": metaData]
        
        //let jsonObj = try? JSONSerialization.data(withJSONObject: params, options: [])
        let URL = "https://elmhackhub.com/api/v1/posts";
        let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var post_id = ""
        Alamofire.request(encodedUrl!, method: .post, parameters:params, encoding: JSONEncoding.default, headers: headers).responseJSON{
            response in
            switch response.result{
            case .success:
                print("in success")
                if let JSON = response.result.value {
                    print("heey")
                    let data = JSON as! [String: Any]
                    post_id = data["post_id"] as! String
                    
                    if (self.image != nil) {
                        self.uploadImage(post_id: post_id, token: token!)
                    }
                }
                
            case .failure(let error):
                print("in failure")
                print(error)
                //debugPrint(response)
//                print(params)
//                print(headers)
                
            }
        }
    }
    func uploadImage(post_id:String, token:String){
        
        let URL:String = "https://elmhackhub.com/api/v1/posts/\(post_id)"
        let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let imageData = UIImagePNGRepresentation(self.image!)!
        
        Alamofire.upload(imageData, to: encodedUrl!, headers: headers).responseJSON { response in
            debugPrint(response)
        }
        
//        Alamofire.upload(
//            multipartFormData: { MultipartFormData in
//                if((self.image) != nil){
//                    MultipartFormData.append(UIImageJPEGRepresentation(self.image!,  0.025)!, withName: "file", fileName: "imageNew.jpeg", mimeType: "image/jpeg")
//                }
//
//        }, to: encodedUrl!, HTTPHeaders: headers) { (result) in
//
//            switch result {
//            case .success(let upload, _, _):
//
//                upload.responseJSON { response in
//                    // getting success
//                    print(response)
//                }
//
//            case .failure(let encodingError):
//                // getting error
//                print("fail")
//                print(encodingError)
//
//                break
//            }
//
//
//        }
//        if let data = UIImageJPEGRepresentation(self.image!,1) {
//
//            // You can change your image name here, i use NSURL image and convert into string
//            let imageURL = self.info[UIImagePickerControllerPHAsset] as! NSURL
//            let fileName = imageURL.absoluteString
//            // Start Alamofire
//            Alamofire.upload(imageData, to: "https://httpbin.org/post", ).responseJSON { response in
//                debugPrint(response)
//            }
//
//            Alamofire.upload(
//                multipartFormData: { multipartFormData in
//                for (key,value) in parameters {
//                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
//                }
//                multipartFormData.append(data, withName: "avatar", fileName: fileName!,mimeType: "image/jpeg")
//            },
//                             usingTreshold: UInt64.init(),
//                             to: "YourURL",
//                             method: .put,
//                             encodingCompletion: { encodingResult in
//                                switch encodingResult {
//                                case .success(let upload, _, _):
//                                    upload.responJSON { response in
//                                        debugPrint(response)
//                                    }
//                                case .failure(let encodingError):
//                                    print(encodingError)
//                                }
//            })
//        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.info = info
        self.image = image
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
