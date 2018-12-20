//
//  ViewController.swift
//  JSQ
//
//  Created by Ahmed Sengab on 9/21/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import JSQMessagesViewController
struct User
{
    let id:String
    let name:String
}
class ViewController: JSQMessagesViewController {

   
        let user1 = User(id: "1", name: "steve")
        let user2 = User(id: "2", name: "test")
        
        var currentUser: User{
            return user1
        }
        var message = [JSQMessage]()
    
}
extension ViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.message = getMessages()
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
        
        let index1 = ["a","b","c","d"]
        for (temp , number) in index1.enumerated()
        {
            print(number,temp)
        }
        
        
       
    }
}
extension JSQMessagesInputToolbar {
    override open func didMoveToWindow() {
        super.didMoveToWindow()
        if #available(iOS 11.0, *) {
            if self.window?.safeAreaLayoutGuide != nil {
                self.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: (self.window?.safeAreaLayoutGuide.bottomAnchor)!, multiplier: 1.0).isActive = true
            }
        }
    }
}
extension ViewController
{
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return message[indexPath.row]
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubblefactory = JSQMessagesBubbleImageFactory()
        let messagep = message[indexPath.row]
        if currentUser.id == messagep.senderId
        {
          return bubblefactory?.outgoingMessagesBubbleImage(with: .black)

        }
        else
        {
            return bubblefactory?.incomingMessagesBubbleImage(with: .blue)

        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return(message.count)
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let messaget = message[indexPath.row]
        let messageUser = messaget.senderDisplayName
        return(NSAttributedString(string: messageUser!))
    }
    override func  collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
}
extension ViewController
{
    
    func getMessages() -> [JSQMessage]
    {
        var messages = [JSQMessage]()
        let message1 = JSQMessage(senderId: "1", displayName: "stevet", text: "hey milf")
        let message2 = JSQMessage(senderId: "2", displayName: "ys", text: "asfk")
        messages.append(message1!)
        messages.append(message2!)
        return messages
    }
}
