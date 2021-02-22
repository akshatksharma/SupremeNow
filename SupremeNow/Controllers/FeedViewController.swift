//
//  FeedViewController.swift
//  SupremeNow
//
//  Created by Victor Kalil on 2/20/21.
//

import UIKit
import FirebaseFirestore

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fireBaseSetup()
   
        // Do any additional setup after loading the view.
    }
    
    func fireBaseSetup() {
        let db = Firestore.firestore()
        let blah = db.collection("users").document("testID")
        blah.getDocument { (document, error) in
            if let document = document, document.exists {
               // let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let userInfo = document.data()!["info"]! as? String ?? "None"
                print(userInfo)
            }else {
                print("Document does not exist")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
