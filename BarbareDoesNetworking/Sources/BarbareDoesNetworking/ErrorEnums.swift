//
//  ErrorEnums.swift
//  Lecture-23-Homework
//
//  Created by Barbare Tepnadze on 03.05.24.
//

import Foundation

public enum NetworkError: Error {
    case decodeError
    case wrongResponse
    case wrongStatusCode(code: Int)
    case emptyData
}
