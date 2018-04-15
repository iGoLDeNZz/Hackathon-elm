//
//  Post.swift
//  Get Swifty
//
//  Created by Rayan Aldafas on 07/04/2018.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import Foundation

class post{
    
    var user_id : String
    var post_id : String
    var title : String
    var description : String
    var name : String
    var status : Int
    var tag : String?
    var image : String?
    
    init (u: String, p: String, t: String, d: String, n:String, s:Int, im: String) {
        user_id = u
        post_id = p
        title = t
        description = d
        name = n
        status = s
        image = im
    }
    
//    init(u: String, p: String, t: String, d: String, n:String, s:Int, tt: String, im: String) {
//        user_id = u
//        post_id = p
//        title = t
//        description = d
//        name = n
//        status = s
//        tag = tt
//        image = im
//    }
    
    
}
