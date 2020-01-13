//
//  SchoolSignUp2ViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 1/13/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit
import FirebaseAuth
import Apollo

class SchoolSignUp2ViewController: UIViewController {

    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
        guard let schoolId = Auth.auth().currentUser?.uid,
            !schoolId.isEmpty,
            let email = Auth.auth().currentUser?.email,
            !email.isEmpty,
            let schoolName = schoolNameTextField.text,
            !schoolName.isEmpty,
            let address = addressTextField.text,
            !address.isEmpty,
            let city = cityTextField.text,
            !city.isEmpty,
            let zipcode = zipcodeTextField.text,
            !zipcode.isEmpty else { return }
        
        SchoolController.shared.createSchool(schoolId: schoolId, schoolName: schoolName, email: email, address: address, city: city, zipcode: zipcode)
        
        Network.shared.apollo.perform(mutation: AddSchoolMutation(school_id: schoolId, school_name: schoolName, email: email, address: address, city: city, zipcode: zipcode))
        
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "SchoolFlow", bundle: nil)
            let schoolTabBarController = storyboard.instantiateViewController(withIdentifier: "SchoolTabBarController")
            schoolTabBarController.modalPresentationStyle = .fullScreen
            self.present(schoolTabBarController, animated: true, completion: nil)
        }
    }
    
}
