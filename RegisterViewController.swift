//
//  RegisterViewController.swift
//  teatApp
//
//  Created by streifik on 06.12.2022.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var name = String()
    var surname = String()
    var age = Int()
    var password = String()
    var confirmPassword = String()
    var email = String()
    var avatarImage = UIImage(named: "defaultImage")
    var mailArray = [String]()
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func selectPhotoButtonTapped(_ sender: UIButton) {
        let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = false
             
           self.present(image, animated: true) {
          }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        
        // check empty fields
        
        if nameTextField.text == "" ||
           surnameTextField.text == "" ||
           emailTextField.text == "" ||
           ageTextField.text == "" ||
           passwordTextField.text == "" ||
           confirmPasswordTextField.text == "" {
    
           displayMessage(userMessage: "Enter all fields")
        } else {
            if let name = nameTextField.text {
                self.name = name
                print(self.name)
            }
            
            if let surname = surnameTextField.text {
                self.surname = surname
                print(self.surname)
            }
            if let email = emailTextField.text {
                self.email = email
                print(self.surname)
            }
            
            if let password = passwordTextField.text {
                self.password = password
                print(self.password)
            }
            
            if let confirmPassword = confirmPasswordTextField.text {
                self.confirmPassword = confirmPassword
                print(self.confirmPassword)
            }
            
            if let age = ageTextField.text {
                self.age = Int(age) ?? 0
                print(self.age)
            }
            
            // confirm password
            
            guard confirmPassword == password else {
                displayMessage(userMessage: "Passwords does not match")
                return
            }
            
            // add to core data
            
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context: NSManagedObjectContext = appdelegate.persistentContainer.viewContext
            
            // check if email exist
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                print(results)
                for result in results as! [NSManagedObject]{
                    if let mail = result.value(forKey: "email") as? String{
                        self.mailArray.append(mail)
                    }
                }
            }
            catch{
                print("error")
            }
            
            // add new user data
            
            let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)
            let managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
            
            managedObject.setValue(self.password, forKey: "password")
            managedObject.setValue(self.email, forKey: "email")
            managedObject.setValue(self.name, forKey: "name")
            managedObject.setValue(self.surname, forKey: "surname")
            managedObject.setValue(self.age, forKey: "age")
           
            //add image
            // create NSData from UIImage
            if let img = avatarImage {
                let data = img.pngData()
                managedObject.setValue(data, forKey: "profileImage")
            }
            
            appdelegate.saveContext()
            
            // check if email exist
            
            if(mailArray.contains(emailTextField.text!)){
                displayMessage(userMessage: "There is an account with this email address")
            } else {
                
              // переделать. сделать display message с completion
                DispatchQueue.main.async
                    {
                        let alertController = UIAlertController(title: nil, message: "Registration sucessfully. Please log in", preferredStyle: .alert)
                        
                        let OKAction = UIAlertAction(title: "Oк", style: .default) { (action:UIAlertAction!) in
                            self.viewDidLoad()
                            // Code in this block will trigger when OK button tapped.
                          
                            // navigate to Login VC
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            if let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                                   
                                   self.show(loginVC, sender: self)
                                }
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.photoImageView.image = avatarImage
        self.photoImageView.layer.cornerRadius = 70

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var selectedImage: UIImage?
           
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            self.avatarImage = selectedImage!
           
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.avatarImage = selectedImage
            viewDidLoad()
            picker.dismiss(animated: true, completion: nil)
            }
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

