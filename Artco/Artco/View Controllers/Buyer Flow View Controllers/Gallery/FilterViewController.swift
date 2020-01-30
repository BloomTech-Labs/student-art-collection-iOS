//
//  FilterViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 1/28/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit
import DropDown

// At the time of the RC2 demo, searching was only feasible with local filtering due to backend complexities. When functional, it is recommended to implement GraphQL queries depending on user inputs. 

class FilterViewController: UIViewController {

    // MARK: - Properties and outlets
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var zioCodeTextField: UITextField!
    @IBOutlet weak var schoolNameCategory: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    let categoryDropDown = DropDown()

    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DropDown.startListeningToKeyboard()
        initializeDropDown()
    }
    
    // MARK: - Actions and functions
    
    private func initializeDropDown() {
           categoryDropDown.anchorView = categoryTextField.rightView
           categoryTextField.rightViewMode = .always
           categoryDropDown.direction = .bottom
           categoryDropDown.dismissMode = .onTap
           categoryDropDown.dataSource = ["Photography", "Drawing", "Painting", "Sculpture", "Other"]
        categoryTextField.addTarget(self, action:#selector(dropDown), for: .allEditingEvents)
           categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
               self.categoryTextField.text = item
           }
       }
       
       @objc func dropDown() {
           categoryDropDown.show()
       }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let filterString = zioCodeTextField.text else { return }
        let zipcode = Notification.Name(String.filterNotificationKey)
        NotificationCenter.default.post(name: zipcode, object: nil, userInfo: ["name": filterString])
        dismiss(animated: true, completion: nil)
    }
    
}
