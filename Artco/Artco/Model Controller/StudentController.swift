//
//  StudentController.swift
//  Artco
//
//  Created by Alex Rhodes on 1/6/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation

class StudentController {
    
    // MARK: - Properties
    
    static let shared = StudentController()
    
    // MARK: - Functions
    
    @discardableResult func createStudent(studentName: String, bio: String) -> Student {
        let student = Student(studentName: studentName, bio: bio)
        CoreDataStack.shared.save()
        return student
    }
    
    @discardableResult func updateStudent(student: Student, studentName: String, bio: String, artwork: [Listing]?) -> Student {
        student.studentName = studentName
        student.bio = bio
        CoreDataStack.shared.save()
        return student
    }
    
    func deleteStudent(student: Student) {
        CoreDataStack.shared.mainContext.delete(student)
        CoreDataStack.shared.save()
    }
    
    
    
}
