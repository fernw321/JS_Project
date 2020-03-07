//
//  SignupViewController.swift
//  JSProject_1
//
//  Created by William Fernandez on 12/6/19.
//  Copyright © 2019 William Fernandez. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add the festure recognizer to get rid of the keyboard
        Utilities.removeKeyboardTapGesture(self.view)
        // Style the UI elements
        style()
    }
    // Use the static file to style the elements
    func style() {
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleHollowButton(signUpButton)
        
        errorLabel.isHidden = true
    }
    
    // Check the fields and validate that the data is correct. If this method is correct, returns nil. Otherwise it return the error message
    func validateFields() -> String? {
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all the fields."
        }
        // Clean up the typed in password
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // If the password is valid, return nil. The error label won't show anything
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 character long, contains a special character and a number."
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        // Validate the fields and store the error message in a variable
        let error = validateFields()
        // If the error is not nil...
        if error != nil {
            // There's something wrong with the fields. Show error message.
            showError(error!)
        } else {
            // Create cleaned version of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Check for errors
                if err != nil {
                    // There was an error creating the user
                    self.showError("Error creating user")
                } else {
                    // User was created successfully, now store the firstName and lastName
                    let db = Firestore.firestore()
                                        
                    db.collection("users").document((result?.user.uid)!).setData([
                        "name": firstName,
                        "lastName": lastName,
                        "email": email
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    // Transition to the home screen
                    Utilities.transitionToHome(self.view)
                }
            }
        }
    }
    
    
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}


