//
//  RestrictedTextField.swift
//  Alireza
//
//  Created by Alireza on 2023-03-18.
//

import UIKit

class RestrictedTextField: UITextField {
    
    override func deleteBackward() {
        if let text = self.text, !text.isEmpty {
            self.text = String(text.dropLast())
        }
    }
    
    func addCharacter(_ character: String) {
        if character == "-" {
            if self.text?.isEmpty ?? true {
                self.text = character
            }
        } else if character == "." {
            if let text = self.text, !text.contains(".") {
                self.text = text + character
            }
        } else {
            if let text = self.text {
                if text == "0" || text == "-0" {
                    self.text = (text.first == "-" ? "-" : "") + character
                } else {
                    self.text = text + character
                }
            } else {
                self.text = character
            }
        }
    }
}
    
