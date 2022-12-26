//
//  StartPageViewController.swift
//  teatApp
//
//  Created by streifik on 06.12.2022.
//

import UIKit

class StartPageViewController: UIViewController {

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let editProfileViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
               self.show(editProfileViewController, sender: self)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let editProfileViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
               
               self.show(editProfileViewController, sender: self)
        }
    }
    

}
