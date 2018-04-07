//
//  AddPostViewController.swift
//  Get Swifty
//
//  Created by Rayan Aldafas on 07/04/2018.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController {

    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var TagsTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    
    @IBOutlet weak var addPostButton: UIButton!
    
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
