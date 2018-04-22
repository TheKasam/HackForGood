//
//  tableViewViewController.swift
//  SealUI
//
//  Created by Sai Kasam on 4/21/18.
//  Copyright © 2018 Sai Kasam. All rights reserved.
//

import UIKit
import Firebase

class tableViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var groceryList: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "admin1", for: indexPath) as! adminPageOneTableViewCell
        
        cell.eventName.text = groceryList[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let databaseRef = Database.database().reference().child("AllEventNames")
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
