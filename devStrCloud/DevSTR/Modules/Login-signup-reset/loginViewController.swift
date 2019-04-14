//
//  loginViewController.swift
//  DevSTR
//
//  Created by ShreeThaanu RK on 10/03/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class loginViewController: UIViewController {
    
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet var gestureRecogizer: UITapGestureRecognizer!
    @IBOutlet weak var googleButtonSignin: UIButton!
    
    var httpRequest = CSSwiftApiHttpRequest()
    var nam = ""
    var imga = ""
    var profimgString : String!
  // weak var delegate: loginSuccess?
    var dict : [String : AnyObject]!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func closeAction(_ sender: Any) {
        
//        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeViewController") as! ViewController
//        self.present(vc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAction(_ sender: Any) {
    }
    
    @IBAction func SignIn(_ sender: Any) {
        login()
        
    }
    
    @IBAction func gestureAction(_ sender: Any) {
    }
    
    func login()
    {
   let url:String = LOCAL_URL + "users/login.php"


        let params:[String:String] = [
            "email":       email.text!,
            "password":    password.text!,
            "mobile": "",
        ]
        print(params)
      httpRequest.PostMethodWithOtherHeader(url: url, view: self.view, Parameter: params as [String : AnyObject], ResponseBlock: {(response) -> Void in

            let content = String(data: response as! Data, encoding: String.Encoding.utf8)

            let responseData = Mapper<loginModel>().map(JSONString: content!)
            if(responseData?.statuscode == 200)
            {
               
                print("LOGGED in successfully")
               
                let usernamea = responseData?.responseRequired[0].userName
               GlobalConstants.General.USERDEFAULTS.setValue(usernamea, forKey: GlobalConstants.Login.CSUserName)

                let emaila = responseData?.responseRequired[0].userEmail
                
                GlobalConstants.General.USERDEFAULTS.setValue(emaila, forKey: GlobalConstants.Login.CSEmail)

                print(GlobalConstants.General.USERDEFAULTS.object(forKey: GlobalConstants.Login.CSEmail)!)

                let userid = responseData?.responseRequired[0].id

                GlobalConstants.General.USERDEFAULTS.setValue(userid, forKey: GlobalConstants.Login.CSUserToken)

                strSharedData.SharedInstance.isLoggedIn = true
                
               let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.present(vc, animated: true, completion: nil)
           }
                
           else {
           
        }
      })
    }
    
}
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 15
        self.layer.cornerRadius = 20
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension loginViewController : UITextFieldDelegate {
    /// Scrollview's ContentInset Change on Keyboard hide
    
    /// UnRegistering Notifications
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    /// register Keyboard
    func registerKeyboardNotifications() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(ChangePasswordViewController.keyboardDidShow(notification:)),
//                                               name: NSNotification.Name.UIKeyboardDidShow,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(ChangePasswordViewController.keyboardWillHide(notification:)),
//                                               name: NSNotification.Name.UIKeyboardWillHide,
//                                               object: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            _ = password.becomeFirstResponder()
        } else if textField == password {
           // dismissKeyboard()
            textField.endEditing(true)
        }
        return true
    }
}


