//
//  LoginViewController.swift
//  teatApp
//
//  Created by streifik on 06.12.2022.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    var email = String()
    var password = String()
    
    var mailArray = [String]()
    var passwordArray = [String]()
    
    var users = [User]()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {

        
        // check empty fields
        
        if emailTextField.text == "" ||
           passwordTextField.text == "" {
           displayMessage(userMessage: "Enter all fields")
            
        } else {
            if let email = emailTextField.text {
                self.email = email
                print(self.email)
            }
            
            if let password = passwordTextField.text {
                self.password = password
                print(self.password)
            }
            
            // get all users data
            
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appdelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                 //   fetchRequest.returnsObjectsAsFaults = false
                    
                    do{
                        let results = try context.fetch(fetchRequest)
                        
                        self.users = results as! [User]
                       
                        
                        for result in results as! [NSManagedObject]{

                            if let mail = result.value(forKey: "email") as? String{
                                self.mailArray.append(mail)
                            }
                            if let password = result.value(forKey: "password") as? String{
                                self.passwordArray.append(password)
                            }
                        }
                    }
                    catch {
                        print("error")
                    }
            
            // check if password and email match
            
            if (mailArray.contains(emailTextField.text!)){
                let userIndex = mailArray.firstIndex(where: {$0 == emailTextField.text})
                if passwordArray[userIndex!] == passwordTextField.text {
                    let user = self.users[userIndex!]
                    print(user)
                    
            // navigate to profile VC
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if let tabBar = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                            
                if let tabBarVC = tabBar.viewControllers?[0] {
                    if let nav = tabBarVC as? UINavigationController {
                        if let profileViewController = nav.topViewController as? ProfileViewController {
                                        profileViewController.user = user
                            tabBar.selectedIndex = 0
                                    }
                                }
                            }
                if let tabBarSecondItem = tabBar.viewControllers?[1] {
                    if let nav = tabBarSecondItem as? UINavigationController {
                        if let dialogsViewController = nav.topViewController as? DialogsViewController {
                            if let userName = user.name {
                               
                            dialogsViewController.userName = userName
                                    }
                            if let userEmail = user.email {
                                dialogsViewController.userEmail = userEmail
                            }
                                }
                            }
                    }
                
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.pushViewController(tabBar, animated: true)
               
                                }
                } else {
                    displayMessage(userMessage: "Wrong password")
                        }
            } else {
                displayMessage(userMessage: "This mail does not exist")
                        }
                    }
                }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    func displayMessage(userMessage:String)  {
    DispatchQueue.main.async
        {
            let alertController = UIAlertController(title: nil, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Oк", style: .default) { (action:UIAlertAction!) in
                self.viewDidLoad()
                // Code in this block will trigger when OK button tapped.
              
                DispatchQueue.main.async
                    {
                        print("Ok button tapped")
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
}
