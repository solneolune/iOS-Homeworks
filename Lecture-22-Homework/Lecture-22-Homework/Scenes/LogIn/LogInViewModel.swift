//
//  LogInViewModel.swift
//  Lecture-22-Homework
//
//  Created by Barbare Tepnadze on 26.04.24.
//

import UIKit

class LogInViewModel: NSObject {
    var user: User?
    var selectedProfileImage: UIImage?
    var completion: ((UIImage?) -> Void)?
    
    var firstTimeLoggedIn: Bool {
        get {
            UserDefaults.standard.bool(forKey: "firstTimeLoggedIn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "firstTimeLoggedIn")
        }
    }
    
    // MARK: - User Functions
    func saveUser(name: String, password: String) {
        if !firstTimeLoggedIn {
            let user = User(name: name, password: password)
            KeychainHelper.save(user)
            firstTimeLoggedIn = true
            print("User saved to Keychain: \(user)")
            print("იუზერი პირველად დალოგინდა.")
        } else {
            print("ნაცნობი მომხმარებელი.")
        }
    }
    
    func retrieveUser() -> User? {
        let user = KeychainHelper.retrieve()
        print("User retrieved from Keychain: \(user ?? User(name: "", password: ""))")
        return user
    }
    
    // MARK: - Image Functions
    func selectProfileImage(completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let viewController = windowScene.windows.first?.rootViewController {
            viewController.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func saveProfileImage(_ image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents Directory not found.")
            completion(false)
            return
        }
        
        let profileImageURL = documentsDirectory.appendingPathComponent("profileImage.png")
        
        if let imageData = image.pngData() {
            do {
                try imageData.write(to: profileImageURL)
                print("Profile image saved to Documents Directory: \(profileImageURL)")
                completion(true)
            } catch {
                print("Failed to save profile image: \(error)")
                completion(false)
            }
        } else {
            print("Failed to convert image to PNG data.")
            completion(false)
        }
    }
}

// Mark: - Extension ImagePicker
extension LogInViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            selectedProfileImage = selectedImage
            saveProfileImage(selectedImage) { success in
                if success {
                    print("Profile image saved successfully.")
                } else {
                    print("Failed to save profile image.")
                }
            }
            if let completion = completion {
                completion(selectedProfileImage)
            }
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let viewController = windowScene.windows.first?.rootViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let viewController = windowScene.windows.first?.rootViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}

