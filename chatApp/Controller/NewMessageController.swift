//
//  NewMessageController.swift
//  chatApp
//
//  Created by Bennett Hartrick on 11/4/17.
//  Copyright © 2017 Bennett. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    let cellId = "cellId"
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        fetchUser()
        
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(dictionary)
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // lets use a hack for now, we actually need to dequeue our cells for memory efficiency
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        cell.textLabel?.text = "Dummy TEXT LALALLA"
        
        return cell
    }
    
}







