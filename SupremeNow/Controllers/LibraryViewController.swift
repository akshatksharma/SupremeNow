//
//  LibraryViewController.swift
//  SupremeNow
//
//  Created by Marissa Kalkar on 2/24/21.
//

import UIKit
import FirebaseFirestore

class LibraryViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Set the arrayOfFavorites as the user default with key "myArray". Accesible across all classes
    var arrayOfFavorites = UserDefaults.standard.stringArray(forKey: "myArray") ?? []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "theCell")! as UITableViewCell
        //myCell.textLabel!.text = arrayOfFavorites[indexPath.row]
        myCell.textLabel!.text = "hello"
        return myCell
        
    }
    
    //function for handling a favorite. Here we store the favorite into a user default array and set it.
     func handleMarkAsFavorite() {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "theCell")! as UITableViewCell
        print("Marked as favorite")
        arrayOfFavorites.append(myCell.textLabel?.text ?? "null")
        UserDefaults.standard.set(arrayOfFavorites, forKey: "myArray")
        print(arrayOfFavorites.count)
    }
    
    //https://programmingwithswift.com/uitableviewcell-swipe-actions-with-swift/
    func tableView(_ tableView: UITableView,trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal,
            title: "Favorite") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavorite()
            completionHandler(true)
        }
        favorite.backgroundColor = .systemGreen
        let configuration = UISwipeActionsConfiguration(actions: [favorite])
        return configuration
    }
    
    //on the click of a favorites view we want to push a new view controller that shows details about the case
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked for details")
//        let selectedCase = (tableView, cellForRowAt: 0)
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetailView", bundle:nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        self.present(detailViewController, animated:true, completion:nil)
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        arrayOfFavorites = UserDefaults.standard.stringArray(forKey: "myArray") ?? []
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfFavorites = UserDefaults.standard.stringArray(forKey: "myArray") ?? []
        tableView.reloadData()
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "theCell")
        tableView.dataSource = self
        print("in library")
    }
    
}
 
