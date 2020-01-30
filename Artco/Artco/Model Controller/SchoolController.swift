//
//  SchoolController.swift
//  Artco
//
//  Created by Mitchell Budge on 1/13/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation

class SchoolController {
    
    // MARK: - Properties
    
    static let shared = SchoolController()
    
    // MARK: - Functions
    
    @discardableResult func createSchool(schoolId: String, schoolName: String, email: String, address: String, city: String, zipcode: String) -> School {
        let school = School(schoolId: schoolId, schoolName: schoolName, email: email, address: address, city: city, zipcode: zipcode)
        CoreDataStack.shared.save()
        return school
    }
    
}
