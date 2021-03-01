//
//  FeedViewController.swift
//  SupremeNow
//
//  Created by Victor Kalil on 2/20/21.
//

import UIKit
import FirebaseFirestore

class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let newCaseContent = [
        ["title": "Google vs Oracle", "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."],
        ["title": "Carney v. Adams", "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit"]
    ]
    
//    this image can be force unwrapped because it is referring to an image locally on this device for testing purposes.
    let topNewsContent = [
        ["title": "Landmark Supreme Court Ruling Against Texas", "caseName": "California v. Texas", "image": UIImage(named:"testImage")!],
        ["title": "Landmark Supreme Court Ruling Against Texas", "caseName": "California v. Texas", "image": UIImage(named:"testImage")!]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
   
        testFireBase()
    }
    
    func testFireBase() {
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


extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return topNewsContent.count
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "New Cases"
        case 1:
            return "Top News"
        default:
            return "meep"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "caseCell", for: indexPath) as? NewCasesCell else { return UITableViewCell() }
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            return cell
        case 1:
            let newsStory = topNewsContent[indexPath.row]
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "topNewsCell", for: indexPath) as? TopNewsCell else { return UITableViewCell() }
            
            cell.newsTitle.text = newsStory["title"] as? String
            cell.newsCase.text = newsStory["caseName"] as? String
            cell.newsImage.image = newsStory["image"] as? UIImage
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
     
        
    }
    
}

extension FeedViewController : UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newCaseContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(newCaseContent[indexPath.item])
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCaseCollectionCell", for: indexPath) as? CaseCell else {
            print("failed")
            return UICollectionViewCell()
        }
        
        cell.titleText.text = newCaseContent[indexPath.item]["title"]
        cell.descriptionText.text = newCaseContent[indexPath.item]["description"]
        
        
        return cell
    }
    
    
}

