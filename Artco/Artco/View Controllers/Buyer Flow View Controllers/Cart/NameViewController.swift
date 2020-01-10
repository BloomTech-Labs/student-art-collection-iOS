//
//  NameViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let nameString = nameTextField.text else { return }
        let name = Notification.Name(String.nameNotificationKey)
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["name": nameString])
        dismiss(animated: true, completion: nil)
    }
}
