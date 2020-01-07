//
//  SEditStudentViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 1/7/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit

class SEditStudentViewController: UIViewController {
    
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    
    var student: Student? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    // MARK: Methods & Actions
    
    private func updateViews() {
        guard let student = student,
            let studentName = student.studentName,
            let bio = student.bio,
            isViewLoaded else {return}
        
        studentNameTextField.text = studentName
        bioTextView.text = bio
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let student = student,
            let studentName = studentNameTextField.text,
            !studentName.isEmpty,
            let bio = bioTextView.text,
            !bio.isEmpty else { return }
        
        StudentController.shared.updateStudent(student: student, studentName: studentName, bio: bio, artwork: nil)
        navigationController?.popViewController(animated: true)
    }
}
