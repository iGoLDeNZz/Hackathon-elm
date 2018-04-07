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
    
    init (u: String, p: String, t: String, d: String, n:String, s:Int) {
        user_id = u
        post_id = p
        title = t
        description = d
        name = n
        status = s
    }
    
    init(u: String, p: String, t: String, d: String, n:String, s:Int, tt: String) {
        user_id = u
        post_id = p
        title = t
        description = d
        name = n
        status = s
        tag = tt
    }
    
    
}
