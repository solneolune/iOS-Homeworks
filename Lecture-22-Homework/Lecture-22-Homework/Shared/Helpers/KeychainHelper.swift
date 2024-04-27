//
//  KeychainHelper.swift
//  Lecture-22-Homework
//
//  Created by Barbare Tepnadze on 27.04.24.
//

import Foundation
import Security

class KeychainHelper {
    static func save(_ user: User) {
        let data = try? JSONEncoder().encode(user)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "user",
            kSecValueData as String: data ?? Data()
        ]
        SecItemAdd(query as CFDictionary, nil)
    }
    
    static func retrieve() -> User? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "user",
            kSecReturnData as String: true
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else { return nil }
        guard let data = result as? Data else { return nil }
        return try? JSONDecoder().decode(User.self, from: data)
    }
}
