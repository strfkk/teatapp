//
//  User.swift
//  teatApp
//
//  Created by streifik on 07.12.2022.
//

import Foundation

struct UserData {
    //
    // MARK: - Variables And Properties
    //
    var name: String
    var surname: String
    var age: Int
    var email: String
   
    //
    // MARK: - Initializer
    //
    init?(name: String, surname: String, age: Int, email: String) {
        
        self.name = name
        self.surname = surname
        self.email = email
        self.age = age
        
        }
    }
