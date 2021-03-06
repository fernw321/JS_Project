//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    
    static func transitionToHome(_ view: UIView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        view.window?.rootViewController = controller
        view.window?.makeKeyAndVisible()
    }
    
    static func removeKeyboardTapGesture(_ view: UIView) {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    static func styleTextField(_ textfield:UITextField) {
        // Create the bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8).cgColor
        // Remove border on text field
        textfield.borderStyle = .none
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button:UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        // Checks if the password is valid
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
