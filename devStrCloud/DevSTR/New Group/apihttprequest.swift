//
//  apihttprequest.swift
//  DevSTR
//
//  Created by ShreeThaanu RK on 09/03/19.
//  Copyright © 2019 strlab. All rights reserved.
//


import UIKit
import Alamofire
import Toast_Swift

typealias JSONResponseBlock =  Dictionary<String, AnyObject>

class CSSwiftApiHttpRequest: UIView {
    var DEVICE_TOKEN = "deviceId"
    var ACCESS_TOKEN = "ACCESS_TOKEN"
    var BASE_URL = "BASE_URL"
    //MARK:-Get method without header
    /**
     
     this method used send http request in get method
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func getMethod(url:String, view:UIView,parameter: [String:String],ResponseBlock:@escaping (_ response: AnyObject) -> Void){
        
        //   KRProgressHUD.show()
        
        let reachablityManageer = Alamofire.NetworkReachabilityManager(host:url)
        if(reachablityManageer?.isReachable)!{
            
            view.isUserInteractionEnabled = false
            Alamofire.request(url).responseJSON { response in
                //    KRProgressHUD.dismiss()
                
                view.isUserInteractionEnabled = true
                
                switch response.result {
                    
                case .success:
                    
                    //   KRProgressHUD.dismiss()
                    
                    print("Response Successful")
                    let JSON = response.result.value
                    //let responseData: [String: AnyObject] = ["Response" : JSON! as AnyObject]
                    ResponseBlock( (response.data as AnyObject? ?? NSData()))
                    print("JSON: \(JSON)")
                    
                case .failure(let error):
                    //       KRProgressHUD.dismiss()
                    
                    print(error)
                }
            }
            
        }else{
            //   KRProgressHUD.dismiss()
            
            view.makeToast("No Internet Connection" , duration: 3.0, position: .bottom)
        }
        
    }
    
    //MARK:-Get method with header
    /**
     
     this method used send http request in get method and pass userid and token in header
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func getMethodWithHeader(url:String, view:UIView,parameter: [String:String],ResponseBlock:@escaping (_ response: AnyObject) -> Void){
        
        
        //  KRProgressHUD.show()
        
        //   ACESS_TOKEN = GlobalConstants.General.USERDEFAULTS.object(forKey: GlobalConstants.Login.CSUserToken) as? String
        DEVICE_TOKEN = "deviceId"
        
        let reachablityManageer = Alamofire.NetworkReachabilityManager(host:url)
        if(reachablityManageer?.isReachable)!{
            view.isUserInteractionEnabled = false
            let header:[String:String] = [:]
                
                //"X-REQUEST-TYPE":"mobile",
                //   "X-ACCESS-TOKEN":ACESS_TOKEN,
                //"X-DEVICE-TOKEN":DEVICE_TOKEN,
               // "Content-Type": "application/json"]
            print(header)
            //Alamofire.Manager.sharedInstance.session.configuration.requestCachePolicy = .ReloadIgnoringLocalCacheData
            
            // Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                
                // SVProgressHUD.dismiss()
                view.isUserInteractionEnabled = true
                let statuscode = response.response?.statusCode
                let responseData: [String: AnyObject]
                
                switch response.result {
                    
                case .success:
                    //     KRProgressHUD.dismiss()
                    
                    
                    if ( statuscode == 200){
                        
                        print("Response Successful")
                        
                        _ = response.result.value
                        
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                    }else if (statuscode == 422){
                        
                        let JSON = response.result.value
                        
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
                    }else {
                        let JSON = response.result.value
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
                    }
                    
                    
                case .failure(let error):
                    
                    //      KRProgressHUD.dismiss()
                    responseData = ["Status" :"FAILURE" as AnyObject]
                    print("Error: \(error)")
                    print("Response: \(responseData)")
                }
            }
            
        }else{
            //   KRProgressHUD.dismiss()
            
            view.makeToast("No Internet Connection" , duration: 3.0, position: .bottom)
        }
    }
    
    //MARK:-post method with login header
    /**
     
     this method used send http request in post method and pass request type in header
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func PostMethodWithLoginHeader(url:String, view:UIView,Parameter :[String:AnyObject],ResponseBlock:@escaping (_ response: AnyObject) -> Void){
        
        //  KRProgressHUD.show()
        
        // setting Header for api
        
        let header:[String:String] = [
            
            "X-REQUEST-TYPE":"mobile",
            ]
        //print(header)
        let reachablityManageer = Alamofire.NetworkReachabilityManager(host:url)
        if(reachablityManageer?.isReachable)!{
            view.isUserInteractionEnabled = false
            
            Alamofire.request(url, method: .post, parameters: Parameter, encoding: JSONEncoding.default, headers: header).responseJSON{ (response:DataResponse<Any>) in
                
                //    KRProgressHUD.dismiss()
                
                view.isUserInteractionEnabled = true
                let statuscode = response.response?.statusCode
                let responseData: [String: AnyObject]
                
                switch response.result {
                    
                case .success:
                    
                    if ( statuscode == 200){
                        print("Response Successful")
                        let JSON = response.result.value
                        
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        print("JSON: \(JSON)")
                    } else if ( statuscode == 422){
                        let JSON = response.result.value
                        
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
                        print("JSON: \(JSON)")
                    }else {
                        let JSON = response.result.value
                        
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
                        print("JSON: \(JSON)")
                    }
                    
                case .failure(let error):
                    //           KRProgressHUD.dismiss()
                    responseData = ["Status" :"FAILURE" as AnyObject]
                    print("Error: \(error)")
                    print("Response Data: \(responseData)")
                }
            }
        }else{
            // KRProgressHUD.dismiss()
            
            view.makeToast("No Internet Connection" , duration: 3.0, position: .bottom)
        }
    }
    
    //MARK:-Post method with other header
    /**
     
     this method used send http request in post method and pass device token, content type, request type and accesstoken in header
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func PostMethodWithOtherHeader(url:String, view:UIView,Parameter :[String:AnyObject],ResponseBlock:@escaping (_ response: AnyObject) -> Void){
        
        //   KRProgressHUD.show()
        
      //  ACCESS_TOKEN = "ACCESS_TOKEN"
        //     DEVICE_TOKEN = deviceId
        
        // setting Header for api
        
        let header:[String:String] = [
            
            //    "X-REQUEST-TYPE":"mobile",
            //    "X-ACCESS-TOKEN":ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        //print(header)
        let reachablityManageer = Alamofire.NetworkReachabilityManager(host:url)
        
        if(reachablityManageer?.isReachable)!{
            view.isUserInteractionEnabled = false
            
            Alamofire.request(url, method: .post, parameters: Parameter, encoding: JSONEncoding.default, headers: header).responseJSON{ (response:DataResponse<Any>) in
                
                //        KRProgressHUD.dismiss()
                
                view.isUserInteractionEnabled = true
                let statuscode = response.response?.statusCode
                let responseData: [String: AnyObject]
                
                switch response.result {
                    
                case .success:
                    
                    if ( statuscode == 200){
                        print("Response Successful")
                        _ = response.result.value
                        //responseData = ["Response" : JSON! as AnyObject,"Status" :"SUCESS" as AnyObject]
                        
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        
                    } else if ( statuscode == 422){
                        let JSON = response.result.value
                        //responseData = ["Response" : JSON! as AnyObject,"Status" :"FAILURE" as AnyObject]
                        
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        // self.show(message: ((JSON as AnyObject).value(forKey: "message") as? NSString) as! String)
                        //    self.showToastMessageTop(message: "Internal server error")
                        //view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
                        
                    }else {
                        let JSON = response.result.value
                        //responseData = ["Response" :JSON! as AnyObject,"Status": "FAILURE" as AnyObject]
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        //    self.showToastMessageTop(message: ((JSON as AnyObject).value(forKey: "message") as? NSString) as! String)
                        //    self.showToastMessageTop(message: "Internal server error")
                        //  view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
                    }
                    
                    
                case .failure(let error):
                    
                    //             if ((error as NSError).code == -1001){
                    //
                    //                //  view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter)
                    //            }else if ((error as NSError).code == -1009){
                    //
                    //                // view.makeToast("The Internet connection appears to be offline.", duration: TOAST_DUR, position: CSToastPositionCenter)
                    //            }
                    //    KRProgressHUD.dismiss()
                    responseData = ["Status" :"FAILURE" as AnyObject]
                    print("Error: \(error)")
                    //   self.showToastMessageTop(message: "Internal server error")
                    print("Response Data: \(responseData)")
                }
            }
        }else{
            //  KRProgressHUD.dismiss()
            //  self.showToastMessageTop(message: "No Internet Connection")
        }
    }
    
    
    //MARK:-Post method without header
    /**
     
     this method used send http request in post method
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    
    
    
    //    func postmethodwithmytoken(url:String, view:UIView,Parameter :[String:AnyObject],ResponseBlock:@escaping (_ response: AnyObject) -> Void){
    //
    //        KRProgressHUD.show()
    //
    //        ACESS_TOKEN = GlobalConstants.General.USERDEFAULTS.object(forKey: GlobalConstants.Login.CSUserToken) as? String
    //        DEVICE_TOKEN = deviceId
    //
    //        // setting Header for api
    //
    //        let header:[String:String] = [
    //
    //            "X-REQUEST-TYPE":"mobile",
    //            "X-ACCESS-TOKEN":acce,
    //            "X-DEVICE-TOKEN":DEVICE_TOKEN,
    //            "Content-Type": "application/json"
    //        ]
    //        //print(header)
    //        let reachablityManageer = Alamofire.NetworkReachabilityManager(host:url)
    //
    //        if(reachablityManageer?.isReachable)!{
    //            view.isUserInteractionEnabled = false
    //
    //            Alamofire.request(url, method: .post, parameters: Parameter, encoding: JSONEncoding.default, headers: header).responseJSON{ (response:DataResponse<Any>) in
    //
    //                KRProgressHUD.dismiss()
    //
    //                view.isUserInteractionEnabled = true
    //                let statuscode = response.response?.statusCode
    //                let responseData: [String: AnyObject]
    //
    //                switch response.result {
    //
    //                case .success:
    //
    //                    if ( statuscode == 200){
    //                        print("Response Successful")
    //                        _ = response.result.value
    //                        //responseData = ["Response" : JSON! as AnyObject,"Status" :"SUCESS" as AnyObject]
    //
    //                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
    //
    //                    } else if ( statuscode == 422){
    //                        let JSON = response.result.value
    //                        //responseData = ["Response" : JSON! as AnyObject,"Status" :"FAILURE" as AnyObject]
    //
    //                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
    //                        view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
    //
    //                    }else {
    //                        let JSON = response.result.value
    //                        //responseData = ["Response" :JSON! as AnyObject,"Status": "FAILURE" as AnyObject]
    //                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
    //                        view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
    //                    }
    //
    //
    //                case .failure(let error):
    //
    //                    //             if ((error as NSError).code == -1001){
    //                    //
    //                    //                //  view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter)
    //                    //            }else if ((error as NSError).code == -1009){
    //                    //
    //                    //                // view.makeToast("The Internet connection appears to be offline.", duration: TOAST_DUR, position: CSToastPositionCenter)
    //                    //            }
    //                    KRProgressHUD.dismiss()
    //                    responseData = ["Status" :"FAILURE" as AnyObject]
    //                    print("Error: \(error)")
    //                    print("Response Data: \(responseData)")
    //                }
    //            }
    //        }else{
    //            KRProgressHUD.dismiss()
    //
    //            view.makeToast("No Internet Connection" , duration: 3.0, position: .bottom)
    //        }
    //    }
    //
    
    
    
    func PostMethodWithOutHeader(url:String, view:UIView,Parameter :[String:AnyObject],ResponseBlock:@escaping (_ response: AnyObject) -> Void){
        
        // KRProgressHUD.show()
        
        let reachablityManageer = Alamofire.NetworkReachabilityManager(host:url)
        if(reachablityManageer?.isReachable)!{
            view.isUserInteractionEnabled = false
            
            Alamofire.request(url, method: .post, parameters: Parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON{ (response:DataResponse<Any>) in
                
                //  KRProgressHUD.dismiss()
                
                view.isUserInteractionEnabled = true
                let statuscode = response.response?.statusCode
                let responseData: [String: AnyObject]
                
                switch response.result {
                    
                case .success:
                    
                    if ( statuscode == 200){
                        print("Response Successful")
                        _ = response.result.value
                        //responseData = ["Response" : JSON! as AnyObject,"Status" :"SUCESS" as AnyObject]
                        
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        
                    } else if ( statuscode == 422){
                        let JSON = response.result.value
                        //responseData = ["Response" : JSON! as AnyObject,"Status" :"FAILURE" as AnyObject]
                        
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
                        
                    }else {
                        let JSON = response.result.value
                        //responseData = ["Response" :JSON! as AnyObject,"Status": "FAILURE" as AnyObject]
                        ResponseBlock( (response.data as AnyObject? ?? NSData()))
                        view.makeToast(((JSON as AnyObject).value(forKey: "message") as? NSString) as! String, duration: 3.0, position: .bottom)
                    }
                    
                    
                case .failure(let error):
                    responseData = ["Status" :"FAILURE" as AnyObject]
                    print("Error: \(error)")
                    print("Response Data: \(responseData)")
                }
            }
        }else{
            //      KRProgressHUD.dismiss()
            
            view.makeToast("No Internet Connection" , duration: 3.0, position: .bottom)
        }
    }
    
    //MARK:-Image update function
    /**
     
     this method used to update image with header device oken, req type and access token.
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func imageUpdate(appendURLAction:String,profileImage:UIImage?,parameter:[String:Any], completion: @escaping (_ response: AnyObject) -> Void, errorOccured: @escaping (_ error: NSError?) -> Void){
        
        //setting network activity Indicator to visible
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //    KRProgressHUD.show()
        
        
        
        //  ACESS_TOKEN = GlobalConstants.General.USERDEFAULTS.object(forKey: GlobalConstants.Login.CSUserToken) as? String
        //      DEVICE_TOKEN = deviceId
        // print("the device id is \(deviceId)")
        
        let header:[String:String] = [
            
            "X-REQUEST-TYPE":"mobile",
            //     "X-ACCESS-TOKEN":ACESS_TOKEN,
            "X-DEVICE-TOKEN":DEVICE_TOKEN
        ]
        
        Alamofire.upload(multipartFormData: { MultipartFormData in
            for (key, value) in parameter {
                
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                
            }
            if let image = profileImage{
                if let imageData = UIImageJPEGRepresentation((image), 0){
                    MultipartFormData.append(imageData, withName: "profile_image", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
            }
            
        },to:BASE_URL+"updateprofile",headers: header
            )
        { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            //    KRProgressHUD.dismiss()
            
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    
                    print(response.result.value ?? String())
                    print(response.data ?? NSData())
                    // send to completion block
                    completion(response.data as AnyObject? ?? NSData())
                }
                
            case .failure(let encodingError):
                print(encodingError)
                errorOccured(encodingError as NSError?)
                
            }
        }
    }
    
}
