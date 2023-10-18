//
//  Employee.swift
//  TableEmployee
//
//  Created by P090MMCTSE011 on 18/10/23.
//

import Foundation

struct EmployeeResponse: Decodable {
    var status, message: String
    var data: [Employee]?
}

struct Employee: Decodable {
    var name, profileImage: String
    var id, age, salary: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "employee_name"
        case age = "employee_age"
        case salary = "employee_salary"
        case profileImage = "profile_image"
    }
}
