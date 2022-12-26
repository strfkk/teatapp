//
//  ProfileViewController.swift
//  teatApp
//
//  Created by streifik on 06.12.2022.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController{
    
    var name = String()
    var surname = String()
    var email = String()
    var age = Int()
    
    var avatarImage = UIImage(named: "defaultImage")
    
    var user = User()
    var userData: UserData?
    
    var profileTextData = [
               ("Name",""),
               ("Surname",""),
               ("Age","")
           ]
    
   
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let startVC = storyBoard.instantiateViewController(withIdentifier: "StartPageViewController") as? StartPageViewController {
            let navController = UINavigationController(rootViewController: startVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
         navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated:true, completion: nil)
           // self.navigationController?.pushViewController(startVC, animated: true)
        }
    }
    
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let user = fetchUserData() {
     
            print(user)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        if let userName = user.value(forKey: "name") as? String{
            name = userName
        }
        if let userSurname = user.value(forKey: "surname") as? String{
            surname = userSurname
        }
        if let userEmail = user.value(forKey: "email") as? String{
            email = userEmail
        }
        if let userAge = user.value(forKey: "age") as? Int{
            age = userAge
        }
        
        if let userImageData = user.value(forKey: "profileImage") as? Data{
            print(userImageData)
            if userImageData.isEmpty == false {
            avatarImage = UIImage(data: userImageData)
            
           
            profileTableView.reloadData()
            }

        self.profileTextData = [
           ("Name","\(name)"),
           ("Surname","\(surname)"),
           ("Age","\(String(describing: age))")
                 ]
                    }
                }
    
    
    
    
    func fetchUserData() -> User? {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "name = %@", "qr") // поменять
        do {
            let results = try context.fetch(fetchRequest)
            print(results)
            if let user = results.first as? User {
                return user
                }
            } catch {
                print("Error")
        }
        return nil
    }
            }

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = Int()
        if section == 0 {
            numberOfRows = 1
        } else if section == 1 {
            numberOfRows = profileTextData.count
         }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            
            if let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? AvatarTableViewCell {
            
                cell1.avatarImageView.image = self.avatarImage
                cell1.avatarImageView.layer.cornerRadius = 55
                
                cell = cell1
                }
            } else if indexPath.section == 1 {
             let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
                
                cell2.textLabel?.text = profileTextData[indexPath.row].0
                cell2.detailTextLabel?.text = profileTextData[indexPath.row].1
                
                cell = cell2
        }
        cell.selectionStyle = .none
        return cell
        }
    }
