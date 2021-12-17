//
//  EntryField.swift
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

import SwiftUI

struct EntryField: View {
    // MARK: - Properties
    var sfSymbolName: String
    var placeholder: String
    var prompt: String
    @Binding var field: String
    var isSecure = false
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // MARK: SF Symbol
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                    .frame(width: 20)
                // MARK: Can use SecureField or TextField
                if isSecure {
                    SecureField(placeholder, text: $field)
                } else {
                    TextField(placeholder, text: $field)
                }
            } // HStack
            .autocapitalization(.none)
            .padding(8)
            .background(Color(.secondarySystemBackground))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            // MARK: Prompt (for indications)
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                .foregroundColor(.gray)
        } // VStack
    }
}

// MARK: - Preview
struct EntryField_Previews: PreviewProvider {
     static var previews: some View {
        EntryField(sfSymbolName: "envelope.fill", placeholder: "Email Address", prompt: "Enter a valid email address", field: .constant(""))
    }
}

// MARK: - Copyright notice
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish, distribute, sublicense, create a derivative work, and/or sell copies of the Software in any work that is designed, intended, or marketed for pedagogical or instructional purposes related to programming, coding, application development, or information technology.  Permission for such use, copying, modification, merger, publication, distribution, sublicensing, creation of derivative works, or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
