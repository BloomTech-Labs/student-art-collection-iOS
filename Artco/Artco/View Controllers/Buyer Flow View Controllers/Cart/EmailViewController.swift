//
//  EmailViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        let name = Notification.Name(String.emailNotificationKey)
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["email": email])
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
