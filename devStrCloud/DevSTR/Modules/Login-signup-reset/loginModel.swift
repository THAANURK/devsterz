//
//  loginModel.swift
//  DevSTR
//
//  Created by ShreeThaanu RK on 11/03/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper

class loginModel: Mappable {
    
    var errorstatus: String?
    var statuscode: Int!
    var message: String?
    var status: String?=""
    var UserToken: String?
    var responseRequired : [loginResponse]!
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

class loginResponse: loginModel{
    
    var userName: String?
    var userEmail: String?
    var userPassword: String?
    var id: String?
    var created:String?
    var mobile:String?
    
    //MARK:- Mapping Class Delgate Methods
    override func mapping( map: Map) {
        userName <- map["userName"]
        userEmail <- map["userEmail"]
        userPassword <- map["userPassword"]
        id <- map["id"]
        created <- map["created"]
        mobile <- map["mobile"]
        
    }
}

/*
 
 {
 "scode": 200,
 "msg": "Successfully Logged in",
 "status": true,
 "data": [
 {
 "userName": "thanuu",
 "userEmail": "shre@dev.in",
 "userPassword": "123456",
 "id": "ty",
 "created": "2019-01-09 21:57:40",
 "mobile": "997435672"
 }
 ],
 "error": false
 }
 
 */
