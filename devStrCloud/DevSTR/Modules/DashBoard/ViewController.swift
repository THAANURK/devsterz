//
//  ViewController.swift
//  DevSTR
//
//  Created by PRoVMac on 13/02/19.
//  Copyright © 2019 strlab. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dashboardTable: UITableView!
    let httpRequest = CSSwiftApiHttpRequest()
    var prodResponse = [Response]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPost()
    }
    
    func getPost() {
        let url:String = LOCAL_URL + "posts/getpost.php"
        let params = [String : String]()
        httpRequest.getMethodWithHeader(url: url, view: self.view, parameter: params, ResponseBlock: { (response) -> Void in
            
            let content = String(data: response as! Data, encoding: String.Encoding.utf8)
            print(content ?? String())
           
            let response = Mapper<postMapper>().map(JSONString: content!)
            if (response?.statuscode == 200) {
                self.prodResponse = (response?.responseRequired)!
                print(self.prodResponse)
                self.dashboardTable.reloadData()
            }
            else {
                self.view.makeToast("Error in fetching Data")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return prodResponse.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailPostViewController") as! detailPostViewController
        vc.postId = prodResponse[indexPath.row].postId!
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell
        cell.posterName.text = prodResponse[indexPath.row].postUserId
        cell.posterDesignation.text = "IOS Developer"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
}

