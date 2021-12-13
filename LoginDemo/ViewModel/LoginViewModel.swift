//
//  LoginViewModel.swift
//  LoginDemo
//
//  Created by Juan Carlos Pazos on 11/12/21.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var isEmailCriteriaValid = false
    @Published var isPasswordCriteriaValid = false
    @Published var canSubmit = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    // Regex for valid email
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    // Regex for  8 characters, 1 number, 1 upper case alphabet, 1 lower case alphabet
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,8}$")
    
    init() {
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
        
        Publishers.CombineLatest($isEmailCriteriaValid, $isPasswordCriteriaValid)
            .map { isEmailCriteriaValid, isPasswordCriteriaValid in
                return (isEmailCriteriaValid && isPasswordCriteriaValid)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
        
    }
    
    
    func login() {
        print("Logging in \(username).")
        username = ""
        email = ""
        password = ""
    }
}
