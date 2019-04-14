//
//  constants.swift
//  DevSTR
//
//  Created by ShreeThaanu RK on 11/03/19.
//  Copyright © 2019 strlab. All rights reserved.
//


import Foundation
import UIKit


let BASE_URL = ""
let LOCAL_URL = "http://192.168.1.29/Devsters/"

var ACCESS_TOKEN = "ACCESS_TOKEN"
var DEVICE_TOKEN = "DEVICE_TOKEN"
var deviceId =     "deviceId"
var SIGNEDFROM =   "MOBILE"

let USERDEFAULTS = Foundation.UserDefaults.standard
struct GlobalConstants {
    
    //MARK: Login
    struct Login {
        static let CSLoginKey                   = "alreadyLoggedInKey"
        static let CSEmail                      = "email"
        static let CSPassword                   = "password"
        static let CSUserToken                  = ""
        static let CSUserName                   = "userName"
        static let CSImage                      = "image"
        static let CSId                         = "user_id"
        static let CSProfilePicture             = ""
        static let CSMobile                     = "mobile"
        static let CSGender                     = "gender"
        static let CSIsApproved                 = "isApproved"
        static let CSIsActive                   = "isActive"
        static let csaddress                    = "csaddress"
        static let csstreet                     = "csstreet"
        static let csstateee                     = "csstateee"
        static let cscountry                     = "cscountry"
        static let cszip                         = "cszip"
        static let csaddressname                 = "csname"
        static let csphonenumber                 = "csphonenumber"
        static let cslastname                    = "cslastname"
        static let addressof                     = "addressof"
    }
    struct General {
        static let USERDEFAULTS                 = Foundation.UserDefaults.standard
    }
}
@IBDesignable extension UIView {
    // border color extension storyboard settings
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    // border width extension storyboard settimgs
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    // corner radius extension storyboard settimgs
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
// string validator using as a extention class
//extension String {
//    var isValidEmail: Bool {
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", GlobalConstants.Validation.EMAIL_PATTERN)
//        return emailTest.evaluate(with: self)
//    }
//}



// Description - this is used to convert Colour Hex colour to RGB colour
extension UIColor{
    func HexToColor(_ hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}

