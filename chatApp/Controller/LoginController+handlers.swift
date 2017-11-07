//
//  LoginController+handlers.swift
//  chatApp
//
//  Created by Bennett Hartrick on 11/4/17.
//  Copyright © 2017 Bennett. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handleRegister() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            // successfully authenticated user
            let imageName = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageURL]
                        self.registerUserInotDatabaseWithUID(uid: uid, values: values)
                    }
                })
            }
        }
    }
    
    private func registerUserInotDatabaseWithUID(uid: String, values: [String: Any]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
//            self.messagesController?.navigationItem.title = values["name"] as? String
            let user = User()
            user.name = values["name"] as? String
            user.email = values["email"] as? String
            user.profileImageUrl = values["profileImageUrl"] as? String
            self.messagesController?.setupNavBarWithUser(user: user)
            
            self.dismiss(animated: true, completion: nil)
            
        })
    }
    
    @objc func handleSelectProfileImageView() {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled picker")
        dismiss(animated: true, completion: nil)
    }
    
}
