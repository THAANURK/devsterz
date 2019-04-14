//
//  postMapper.swift
//  DevSTR
//
//  Created by ShreeThaanu RK on 09/03/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import UIKit
import ObjectMapper

class postMapper: Mappable {
    
    var errorstatus: String?
    var statuscode: Int!
    var message: String?
    var status: String?=""
    var UserToken: String?
    var responseRequired : [Response]!
    //MARK:- Mapping Class Delgate Methods
    required init?( map: Map) {
    }
    func mapping( map: Map) {
        // direct conversion
        errorstatus <- map["error"]
        statuscode   <- map["scode"]
        message <- map["msg"]
        status <- map["status"]
        UserToken <- map["UserToken"]
        responseRequired <- map["data"]
    }
}

class Response: postMapper{
  
    var postId: String?
    var postTitle: String?
    var postUserId: String?
    var postContent: String?
    var postUrl:String?
    var postImg:String?
    var postTime: String?
    
    //MARK:- Mapping Class Delgate Methods
    override func mapping( map: Map) {
        postId <- map["postId"]
        postTitle <- map["postTitle"]
        postUserId <- map["postUserId"]
        postContent <- map["postContent"]
        postUrl <- map["postUrl"]
        postImg <- map["postImg"]
        postTime <- map["postTime"]
        
    }
}


//{
//    "postId": "",
//    "postTitle": "",
//    "postUserId": "",
//    "postContent": "",
//    "postUrl": "",
//    "postImg": "",
//    "postTime": ""
//},
