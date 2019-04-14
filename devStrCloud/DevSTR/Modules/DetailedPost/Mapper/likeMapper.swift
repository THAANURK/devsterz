//
//  likeMapper.swift
//  DevSTR
//
//  Created by ShreeThaanu RK on 28/03/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import Foundation
import ObjectMapper

class likeMapper: Mappable {
    
    var errorstatus: String?
    var statuscode: Int!
    var message: String?
    var status: String?=""
    var UserToken: String?
    var responseRequired : [likeResponse]!
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

class likeResponse: likeMapper{
    
    var PostId: String?
    var userId: String?
   
    //MARK:- Mapping Class Delgate Methods
    override func mapping( map: Map) {
        PostId <- map["PostId"]
        userId <- map["userId"]
    }
}


/*
 {
 "scode": 200,
 "msg": "Like Available",
 "status": true,
 "data": [
 {
 "userId": "1",
 "PostId": "2",
 "likeFlag": "0"
 }
 ],
 "error": false
 }
 
 */
