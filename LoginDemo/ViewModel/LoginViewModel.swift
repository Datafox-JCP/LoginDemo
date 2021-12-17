//
//  LoginViewModel.swift
//  LoginDemo
//
//  Created by Juan Carlos Pazos on 17/12/21.
//
/*
 Login validation view - Evaluation of coding skills for job application
 
 We would like to understand a few things about your approach to code, projects, and the way you build them.
 
 1. The UI must be implemented using SwiftUI
 2. The inputs fields should not be empty
 3. Validations for email (must be a valid email)
 4. Validations for password (should have 8 characters, 1 number, 1 upper case alphabet, 1 lower case alphabet)
 5. Validations for username (should not have spaces and no upper case alphabet)
 6. The app must be responsive for all devices (iPhone SE, iPhone 13, iPad)
 
 */

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    // MARK: - Properties
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var isUserCriteriaValid = false
    @Published var isEmailCriteriaValid = false
    @Published var isPasswordCriteriaValid = false
    @Published var isPasswordConfirmValid = false
    @Published var canSubmit = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    // MARK: - RegEx
    
    // Regex for valid username - No special characters, only letters and numbers 12 characters max and 8 min
    let userPredicate = NSPredicate(format: "SELF MATCHES %@", "\\w{8,12}")
    // Regex for valid email
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    // Regex for  8 characters, 1 number, 1 upper case alphabet, 1 lower case alphabet
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,8}$")
    
    // MARK: - Init
    init() {
        $username
            .map { username in
                return self.userPredicate.evaluate(with: username)
            }
            .assign(to: \.isUserCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        $email
            .map { email in
                return self.emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isEmailCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .map { password in
                return self.passwordPredicate.evaluate(with: password)
            }
            .assign(to: \.isPasswordCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $confirmPassword)
            .map { password, confirmPassword in
                return password == confirmPassword
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest4($isUserCriteriaValid, $isEmailCriteriaValid, $isPasswordCriteriaValid, $isPasswordConfirmValid)
            .map { isUserCriteriaValid, isEmailCriteriaValid, isPasswordCriteriaValid, isPasswordConfirmValid in
                return (isUserCriteriaValid && isEmailCriteriaValid && isPasswordCriteriaValid && isPasswordConfirmValid)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
    }
    
    // MARK: - Prompts
    var userNamePrompt: String {
        isUserCriteriaValid ?
        ""
        :
        "Only letters and numbers 12 characters max and 8 min, no spaces"
    }
    
    var emailPrompt: String {
        isEmailCriteriaValid ?
        ""
        :
        "Enter a valid email address"
    }
    
    var passwordPrompt: String {
        isPasswordCriteriaValid ?
        ""
        :
        "Must have 8 characters containing at least one number and one uppercase letter on one lowercase"
    }
    
    var confirmPasswordPrompt: String {
        isPasswordConfirmValid ?
        ""
        :
        "Password fields to not match"
    }
    
    // MARK: - Functions
    // Shows in console the user name and clears the fields
    func login() {
        print("\(username) has login.")
        username = ""
        email = ""
        password = ""
        confirmPassword = ""
    }
}

// MARK: - Copyright notice
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish, distribute, sublicense, create a derivative work, and/or sell copies of the Software in any work that is designed, intended, or marketed for pedagogical or instructional purposes related to programming, coding, application development, or information technology.  Permission for such use, copying, modification, merger, publication, distribution, sublicensing, creation of derivative works, or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
