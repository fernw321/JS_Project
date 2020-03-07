//
//  LoginViewController.swift
//  JSProject_1
//
//  Created by William Fernandez on 12/6/19.
//  Copyright © 2019 William Fernandez. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add the gesture to remove the keyboard
        Utilities.removeKeyboardTapGesture(self.view)
        // Style the UI elements
        style()
    }
    
    func style() {
        Utilities.styleTextField(usernameField)
        Utilities.styleTextField(passwordField)
        Utilities.styleHollowButton(logInButton)
        errorLabel.isHidden = true
    }

    
    @IBAction func loginTapped(_ sender: Any) {
        // Validate text fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            // Create cleaned versions of the data
            let username = usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            // Sign in
            Auth.auth().signIn(withEmail: username!, password: password!) { [weak self] authResult, err in
              
                if err != nil {
                    self?.showError(err!.localizedDescription)
                } else {
                    Utilities.transitionToHome(self!.view)
                }
            }
        }
    }
    
    func validateFields() -> String? {
        // Check that all fields are filled in
        if usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all the fields."
        }

        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
}
