//
//  ErrorEnums.swift
//  Lecture-22-Homework
//
//  Created by Barbare Tepnadze on 26.04.24.
//

import Foundation

enum NetworkError: Error {
    case decodeError
    case wrongResponse
    case wrongStatusCode(code: Int)
    case invalidUrl
    case emptyData
}
