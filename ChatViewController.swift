//
//  ChatViewController.swift
//  teatApp
//
//  Created by streifik on 08.12.2022.
//

import UIKit
import CoreData

class ChatViewController: UIViewController {
    
    var userEmail = String()
    var userName = String()
    var messages1 = [Message1]()

    var chat = Chat()
    var user = User()
    
    @IBAction func sendMessageButtonTapped(_ sender: UIButton) {
        if let text = sendMessageTextField.text {
        self.addMessageToCoreData(text: text)
            self.sendMessageTextField.text = ""
        }
    }
    
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var sendMessageTextField: UITextField!

    func addMessageToCoreData(text: String) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appdelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chat")
                fetchRequest.returnsObjectsAsFaults = false
        do{
              try context.save()
        } catch{
            print("error")
        }
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message1", into: context) as! Message1
        message.chat = self.chat
        message.text = text
        message.senderEmail = self.userEmail
        
        print(self.user.name)
        print(userName)
        message.senderName = self.user.name
        message.recieverName = chat.userName
        
        print(message.senderName)
        print(message.recieverName)
        
        message.recieverEmail = chat.userEmail  // ?
        message.senderName = self.user.name
        
        let currentDate = Date()
        message.date = currentDate
         
        appdelegate.saveContext()
    
        self.chat.messages.insert(message)
        chatTableView.reloadData()
        do {
            let results = try context.fetch(fetchRequest)

            
            if let chats = results as? [Chat] {
                for chat in chats {
                    print(chat.messages)
                }
            }
            
        } catch {
            print("Error")
        }
        
    }
    override func viewDidLoad() {

        super.viewDidLoad()
        sendMessageButton.setImage(UIImage(named: "sendMessage"), for: .normal)
        
        if let userName = chat.userName {
            self.title = userName
        }
        
        self.chatTableView.separatorStyle = .none
    }

    
}
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chat.messages.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatTableViewCell
    let messages1 = Array(chat.messages.sorted(by: {$0.date! < $1.date!}))
    cell.messageLabel.text = messages1[indexPath.row].text
    
    
    if let date =  messages1[indexPath.row].date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        cell.timeLabel.text = dateFormatter.string(from: date)
    }
    
    
    if messages1[indexPath.row].senderEmail == userEmail {
        
        cell.isComing = false
    } else {
        cell.isComing = true
    }
    
    cell.bubleBackgroundView.layer.cornerRadius = 21
    cell.selectionStyle = .none
    
    return cell
    }
}
