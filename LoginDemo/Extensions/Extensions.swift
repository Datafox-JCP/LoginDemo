//
//  Extensions.swift
//  LoginDemo
//
//  Created by Juan Carlos Pazos on 12/12/21.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
