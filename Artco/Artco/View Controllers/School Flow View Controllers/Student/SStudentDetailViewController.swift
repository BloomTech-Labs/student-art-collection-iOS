//
//  SchoolStudentDetailViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class SStudentDetailViewController: UIViewController {
    
    // MARK: Outlets & Properties
    
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentBioTextView: UITextView!
    
    var student: Student? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    // MARK: Methods & Actions
    
    private func updateViews() {
        guard let student = student,
            let studentName = student.studentName,
            let bio = student.bio,
            isViewLoaded else {return}
        
        studentNameLabel.text = studentName
        studentBioTextView.text = bio
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        guard let student = student else {return}
        StudentController.shared.deleteStudent(student: student)
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditStudentSegue" {
            guard let destination = segue.destination as? SEditStudentViewController else { return }
            destination.student = student
        }
    }
    
}
