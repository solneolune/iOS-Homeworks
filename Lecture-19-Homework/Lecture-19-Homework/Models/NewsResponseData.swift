//
//  NewsResponseData.swift
//  Lecture-19-Homework
//
//  Created by Barbare Tepnadze on 20.04.24.
//

import Foundation


struct NewsResponseData: Decodable {
    var newsList: [News]
    
    enum CodingKeys: String, CodingKey {
        case newsList = "List"
    }
}
