//
//  SchoolAddStudentViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class SAddStudentViewController: UIViewController {
    
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var studentBioTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var student: Student?
    var artwork: [Listing]?
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
//        guard let studentName = studentNameTextField.text,
//            !studentName.isEmpty,
//            let bio = studentBioTextView.text,
//            !bio.isEmpty,
//            let student = student,
//            let artwork = artwork
//            else { return }
//
//        StudentController.shared.updateStudent(student: student, studentName: studentName, bio: bio, artwork: artwork)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addStudentArtworkTapped(_ sender: UITapGestureRecognizer) {
        guard let studentName = studentNameTextField.text,
            !studentName.isEmpty,
            let bio = studentBioTextView.text,
            !bio.isEmpty else { return }
        
        let student = StudentController.shared.createStudent(studentName: studentName, bio: bio)
        self.student = student
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
