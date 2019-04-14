//
//  detailPostViewController.swift
//  DevSTR
//
//  Created by ShreeThaanu RK on 12/03/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class detailPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var postId:String!
    @IBOutlet weak var likeCount: UILabel!
    
    var httpRequest = CSSwiftApiHttpRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        getLikes()
    }
    
    func getLikes() {
        let url:String = LOCAL_URL + "posts/getLikes.php"
        let params:[String:String] = [
            "postId": postId
            ]
        print(params)
        httpRequest.PostMethodWithOtherHeader(url: url, view: self.view, Parameter: params as [String : AnyObject], ResponseBlock: {(response) -> Void in
            
            let content = String(data: response as! Data, encoding: String.Encoding.utf8)
            
            let responseData = Mapper<likeMapper>().map(JSONString: content!)
            
            if(responseData?.statuscode == 200) {
                
                self.likeCount.text = String(describing: responseData?.responseRequired.count)
            }
            else {
               print("STATUS GAALI")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcomment", for: indexPath)
        cell.textLabel?.text = "Nice one ..."
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}
