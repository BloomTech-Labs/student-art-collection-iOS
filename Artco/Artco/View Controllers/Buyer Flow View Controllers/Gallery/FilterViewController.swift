//
//  FilterViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 1/28/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit
import DropDown

class FilterViewController: UIViewController {

    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var zioCodeTextField: UITextField!
    @IBOutlet weak var schoolNameCategory: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    let categoryDropDown = DropDown()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DropDown.startListeningToKeyboard()
        initializeDropDown()

    }
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
        
        dismiss(animated: true, completion: nil)
    }
    
}
