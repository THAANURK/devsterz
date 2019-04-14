//
//  signupViewController.swift
//  DevSTR
//
//  Created by ShreeThaanu RK on 10/03/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class signupViewController: UIViewController {

    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var fb: UIButton!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var cPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
        var httpRequest = CSSwiftApiHttpRequest()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func googleAction(_ sender: Any) {
        
    }
    
    @IBAction func twitterAction(_ sender: Any) {
        
    }
    
    @IBAction func fbAction(_ sender: Any) {
        
    }
    
    func isValidationSuccess() -> Bool {
        
        if (name.text == "") {
          //  self.showToastMessageTop(message: "Please enter the Name")
            return false
        }
        else if (name.text?.isEmpty)! {
          //  self.showToastMessageTop(message: "Please enter the Name")
            return false
        }
        else if (trimString(self.cPassword.text!).count < 6) {
          //  self.showToastMessageTop(message: "Password must be of minimum 6 digits")
            return false
        }
        else if (email.text == "") {
         //   self.view.makeToast("Please enter the email", duration: 3.0, position: .bottom)
            return false
        }
//        if !((email?.text?.validateEmail(true))!) {
//          //  self.showToastMessageTop(message:
//              //  NSLocalizedString("Please enter a vaild E-mail id",
//                       //           comment: "Email"))
//            return false
//        }
        
        return true
    }
    
    func trimString(_ value: String) -> String {
        return value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    @IBAction func SignupAction(_ sender: Any) {
        if isValidationSuccess() {
            signUp()
        }
        else {
            
        }
    }
    @IBAction func closeAction(_ sender: Any) {
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeViewController") as! ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func AlreadyLogin(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// MARK :- API CALL
    
    func signUp()
    {
       let url:String = LOCAL_URL + "users/register.php"
      
        let params:[String:String] = [
            "name": name.text!,
            "mobile": "resree",
            "email": email.text!,
            "password" : password.text!,
        ]
      print(params)
        httpRequest.PostMethodWithOtherHeader(url: url, view: self.view, Parameter: params as [String : AnyObject], ResponseBlock: {(response) -> Void in
            
            let content = String(data: response as! Data, encoding: String.Encoding.utf8)
            
            let responseData = Mapper<loginModel>().map(JSONString: content!)
            if(responseData?.statuscode == 200)
            {
                let vc =  UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! loginViewController
                self.present(vc, animated: true, completion: nil)
            }
            else {
                print(responseData?.message)
            }
            
        })
    }
}
extension signupViewController : UITextFieldDelegate {
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
        if textField == name {
            _ = email.becomeFirstResponder()
        } else if textField == email {
            _ = password.becomeFirstResponder()
        } else if textField == password {
            _ = cPassword.becomeFirstResponder()
        }
        else if textField == cPassword {
          textField.endEditing(true)
        }
        return true
    }
}
