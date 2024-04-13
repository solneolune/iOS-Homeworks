//
//  DataModel.swift
//  Lecture-16-Homework
//
//  Created by Barbare Tepnadze on 12.04.24.
//

import Foundation

enum Gender: String {
    case Female = "female"
    case Male = "male"
    case Other = "other"
}

struct Contact {
    var name: String
    var age: Int
    var gender: Gender
    var hobby: String
    var icon: String?
}
