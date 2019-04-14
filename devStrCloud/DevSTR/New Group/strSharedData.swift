//
//  strSharedData.swift
//  DevSTR
//
//  Created by ShreeThaanu RK on 11/03/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import Foundation
import UIKit

class strSharedData: NSObject {
    
    static let SharedInstance = strSharedData()
    
    /// user constant Access Token
    let userDefault = UserDefaults.standard
    
    var visibleController = UIViewController()
    
    var isLoggedIn:Bool = false
    
    /// This method is used to store the default value
    ///
    /// - Parameters:
    ///   - key: key for user default
    ///   - value: value to store in user defaults
    func setUserDefaults(key:String,value:String){
        userDefault.setValue(value, forKey: key)
        userDefault.synchronize()
    }
    
    /// This method is used to get the userdefault value
    ///
    /// - Parameter key: key to get the value
    func getUserDefaults(key:String)->String{
        if(userDefault.value(forKey: key) != nil) {
            return userDefault.value(forKey: key) as! String
        }
        return ""
    }
    
    /// This method is used to get the accesstoken
    ///
    /// - Returns: accesstoken
    func getAccessToken()->String{
        
        return getUserDefaults(key: "accessToken")
    }
    
    /// This method is used to get the profileImage
    ///
    /// - Returns: profileImage
    func getProfileImage()->String{
        return getUserDefaults(key: "profileImage")
    }
    
    /// This method is used to get the phone Number
    ///
    /// - Returns: phoneNumber
    func getPhoneNumber()->String{
        return getUserDefaults(key: "phoneNumber")
    }
    
    /// This method is used to get the login Type
    ///
    /// - Returns: loginType
    func getLoginType()->String{
        return getUserDefaults(key: "loginType")
    }
    
    /// This method is used to get the login Type
    ///
    /// - Returns: loginType
    func getUserName()->String{
        return getUserDefaults(key: "userName")
    }
    
    /// This method is used to get the stripe Key
    ///
    /// - Returns: loginType
    func getStripeId()->String{
        return getUserDefaults(key: "stripeId")
    }
    
    // This method is used to display error message based on platform
    func displayErrorAlert(parentView: UIViewController, message: String) {
        #if os(iOS)
        //parentView.showToastMessageTop(message:message)
        #else
        self.showAlertViewWithTitleandMessage(title:
            NSLocalizedString("Error", comment: "Error"),
                                              message: message,
                                              parentView: parentView)
        #endif
    }
    
    /// This method is used to get the login Type
    ///
    /// - Returns: loginType
    func getUserId()->String{
        return getUserDefaults(key: "userId")
    }
}
