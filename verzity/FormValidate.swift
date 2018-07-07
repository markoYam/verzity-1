//
//  FormValidate.swift
//  verzity
//
//  Created by Jossue Betancourt on 05/07/18.
//  Copyright © 2018 Jossue Betancourt. All rights reserved.
//

import Foundation
import UIKit

class FormValidate{
    
    // Es vacio
    static func isEmptyTextField(textField: UITextField)->Bool{
        if((textField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) == true){
            return true
        }
        return false
    }
    
    // Validar Email
    static func validateEmail(_ email : String) -> Bool {
        let emailRegex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
            + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // Validar Length y Caracteres
    static func validateLengthAndCharacters(_ textField: UITextField, str : String, range: NSRange, validCharacters: String, maxLength: Int) -> Bool{
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.count + str.count - range.length
        let numberFiltered = validateCharacteres(str, characters: validCharacters)
        return newLength <= maxLength && str == numberFiltered
    }
    
    // Validar Télefono
    static func validatePhone(textField: UITextField)->Bool{
        if (textField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 15 {
            return false
        }else{
            return true
        }
    }
    
    // Validar Max Length
    static func validateMaxLength(_ textField: UITextField, str: String, range: NSRange, maxLength: Int)->Bool{
        guard let text = textField.text else { return true }
        let newLength = text.count + str.count - range.length
        return newLength <= maxLength
    }
    
    // Validar Caracteres
    static func validateCharacteres(_ string: String, characters: String) -> String{
        let aSet = CharacterSet(charactersIn:characters).inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return numberFiltered
    }
}