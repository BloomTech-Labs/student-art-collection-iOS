//
//  MessageViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var messageTextView: UITextView!
    
    // MARK: - Actions

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let message = messageTextView.text else { return }
        let name = Notification.Name(String.messageNotificationKey)
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["message": message])
        dismiss(animated: true, completion: nil)
    }
    

}
