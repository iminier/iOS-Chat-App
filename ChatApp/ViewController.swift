//
//  ViewController.swift
//  ChatApp
//
//  Created by Ivan Minier on 5/21/17.
//  Copyright © 2017 Chic Resonance. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ViewController: JSQMessagesViewController {

    let user1 = User(id: "1", name: "John")
    let user2 = User(id: "2", name: "Larry")
    
    var currentUser: User {
        return user1
    }
    
    // Messages
    var messages = [JSQMessage]()
}

// chat methods

extension ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData {
        return messages[indexPath.row]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubble = JSQMessagesBubbleImageFactory()
        let message = messages[indexPath.row]
        
        if currentUser.id == message.senderId {
            return bubble?.outgoingMessagesBubbleImage(with: .blue)
            
        } else {
        
            return bubble?.incomingMessagesBubbleImage(with: .green)
    
        }
        
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.row]
        let messageUserName = message.senderDisplayName
        
        return NSAttributedString(string: messageUserName!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        
        messages.append(message!)
        
        finishSendingMessage()
    }

}


// viewDidLoad()
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set current user
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
        
        //fill messages in array
        self.messages = getMessages()
    }
}


// getMessages()
extension ViewController {
    func getMessages() -> [JSQMessage] {
        var messages = [JSQMessage]()
        
        let message1 = JSQMessage(senderId: "1", displayName: "John", text: "Hey")
        let message2 = JSQMessage(senderId: "2", displayName: user2.name, text: "Whats up?")
        
        messages.append(message1!)
        messages.append(message2!)
        
        return messages
    }
}
