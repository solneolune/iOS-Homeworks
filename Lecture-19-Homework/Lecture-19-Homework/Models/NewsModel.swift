//
//  NewsModel.swift
//  Lecture-19-Homework
//
//  Created by Barbare Tepnadze on 20.04.24.
//

struct News: Decodable {
    var photoUrl: String
    var time: String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case photoUrl = "PhotoUrl"
        case time = "Time"
        case title = "Title"
    }
}
