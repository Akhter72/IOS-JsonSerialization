//
//  UserModel.swift
//  UserApp
//
//  Created by Mac on 17/07/23.
//

import Foundation

class UserModel {
     var name: String?
     var email: String?
     var phone: String?
     var password: String?
    
    init(name: String? = nil, email: String? = nil, phone: String? = nil, password: String? = nil) {
        self.name = name
        self.email = email
        self.phone = phone
        self.password = password
    }
}
