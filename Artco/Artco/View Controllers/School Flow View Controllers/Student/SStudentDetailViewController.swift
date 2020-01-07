//
//  SchoolStudentDetailViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class SStudentDetailViewController: UIViewController {

    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentBioTextView: UITextView!
    
    var student: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
    }
  
}
