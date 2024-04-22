//
//  ErrorEnums.swift
//  Lecture-20-Homework
//
//  Created by Barbare Tepnadze on 22.04.24.
//

import Foundation

enum NetworkError: Error {
    case decodeError
    case wrongResponse
    case wrongStatusCode(code: Int)
    case invalidUrl
    case emptyData
}
