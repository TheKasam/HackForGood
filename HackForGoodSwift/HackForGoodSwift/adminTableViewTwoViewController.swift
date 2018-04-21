//
//  adminTableViewTwoViewController.swift
//  HackForGoodSwift
//
//  Created by Sai Kasam on 4/21/18.
//  Copyright © 2018 Sai Kasam. All rights reserved.
//

import UIKit
import Firebase

class adminTableViewTwoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var eventDesc: UITextField!
    
    @IBOutlet weak var eventTime: UITextField!
    
    var groceryList: [String] = []

    @IBAction func confirmEvent(_ sender: Any) {
        
    }
    
    @IBAction func addTime(_ sender: Any) {
        let databaseRef = Database.database().reference().child("AllEvents").child(eventName.text!).child("timeList")
        var list = databaseRef.childByAutoId()
        list.setValue(eventTime.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let databaseRef = Database.database().reference().child("AllEvents").child("event1").child("timeList")
        databaseRef.observe(.value, with: {snapshot in
            var newItems = [String]()
            let groceries = snapshot.value as? [String : AnyObject] ?? [:]
            for i in groceries {
                newItems.append(i.value as! String)
            }
            
            self.groceryList = newItems
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "admin2", for: indexPath) as! adminTwoTableViewCell
        cell.timeLabel.text = groceryList[indexPath.row]
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
