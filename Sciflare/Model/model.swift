//
//  model.swift
//  SciFlare
//
//  Created by KCD on 05/07/23.
//

import Foundation


struct model: Codable {
    var id, name, email, mobile: String
    var gender: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, mobile, gender
    }
}



extension model{
    static var abc : [model] = [model(id: "0", name: "abc", email: "1@1.com", mobile: "9999999999", gender: "Male"), model(id: "1", name: "def", email: "2@2.com", mobile: "88888888888", gender: "Female")]
}
