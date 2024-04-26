//
//  ErrorEnums.swift
//  Lecture-21-Homework
//
//  Created by Barbare Tepnadze on 25.04.24.
//

import Foundation

enum NetworkError: Error {
    case decodeError
    case wrongResponse
    case wrongStatusCode(code: Int)
    case invalidUrl
    case emptyData
}
