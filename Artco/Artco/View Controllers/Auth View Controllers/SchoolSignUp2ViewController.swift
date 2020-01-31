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
    
    // MARK: - Outlets
    
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    // MARK: - Actions and functions
    
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
        
        Network.shared.apollo.perform(mutation: AddSchoolMutation(school_id: schoolId, school_name: schoolName, email: email, address: address, city: city, zipcode: zipcode)) { result in
            
             guard let data = try? result.get().data else { return }
            print(data.addSchool.id)
            UserDefaults.standard.set(data.addSchool.id, forKey: "schoolID")
            
        }
        
      
        setServerId()
        
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "SchoolFlow", bundle: nil)
            let schoolTabBarController = storyboard.instantiateViewController(withIdentifier: "SchoolTabBarController")
            schoolTabBarController.modalPresentationStyle = .fullScreen
            self.present(schoolTabBarController, animated: true, completion: nil)
        }
    }
    
    // Almost every GraphQL mutation requires an argument of either the Firebase id (captured when authenticated on Google Firebase) or the school server id (captured by this method that queries for the school's id using the Firebase id). See SchoolServerID.swift where tokens are kept.
    private func setServerId() {
        
        guard let schoolId = SchoolServerID.shared.firebaseId else { return }
        
        Network.shared.apollo
            .fetch(query: SchoolByFirebaseIdQuery(school_id: schoolId)) { [weak self] result in
                
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let graphQLResult):
                    if let serverId = graphQLResult.data?.schoolBySchoolId.id {
                        SchoolServerID.shared.serverId = serverId
                        print(serverId)
                    }
                    
                    if let errors = graphQLResult.errors {
                        let message = errors
                            .map { $0.localizedDescription }
                            .joined(separator: "\n")
                        self.showErrorAlert(title: "GraphQL Error(s)",
                                            message: message)
                    }
                case .failure:
                    print("You suck this didn't work you dumb bitch")
                }
        }
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}
