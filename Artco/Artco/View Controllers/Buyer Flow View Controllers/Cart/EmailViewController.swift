//
//  EmailViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        let name = Notification.Name(String.emailNotificationKey)
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["email": email])
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
