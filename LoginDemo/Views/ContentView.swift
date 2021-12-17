//
//  ContentView.swift
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

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel = LoginViewModel()
    
    // MARK: - View
    var body: some View {
        NavigationView {
            VStack {
                // MARK: Logo image
                Image("datafox")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Spacer()
                
                //MARK: Username
                VStack {
                    // MARK: Username
                    EntryField(sfSymbolName: "person.fill", placeholder: "Username", prompt: viewModel.userNamePrompt, field: $viewModel.username)
                        .onChange(of: viewModel.username, perform: { value in
                            // Don't allow Uppercase and use the extension to trim spaces
                            viewModel.username = String(value.lowercased()).trim()
                        })
                    
                    // MARK: Email
                    EntryField(sfSymbolName: "envelope.fill", placeholder: "Email address", prompt: viewModel.emailPrompt, field: $viewModel.email)
                    
                    // MARK: Password
                    EntryField(sfSymbolName: "lock.fill", placeholder: "Password", prompt: viewModel.passwordPrompt, field: $viewModel.password, isSecure: true)
                        .keyboardType(UIKeyboardType.emailAddress)
                    
                    // MARK: Password confirmation
                    EntryField(sfSymbolName: "lock.fill", placeholder: "Confirm password", prompt: viewModel.confirmPasswordPrompt, field: $viewModel.confirmPassword, isSecure: true)
                        .keyboardType(UIKeyboardType.emailAddress)
                } // VStack
                
                
                //MARK: Forgotten password button
                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        Text("Forgot password?")
                            .foregroundColor(.red)
                            .opacity(0.6)
                            .font(.callout)
                    })
                } // HStack forgotten password
                .padding(4)
                
                Spacer()
                
                //MARK: Login button
                Button {
                    viewModel.login()
                } label: {
                    Text("LOGIN")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(8)
                .opacity(viewModel.canSubmit ? 1 : 0.6)
                .disabled(!viewModel.canSubmit)
                
                Spacer()
                
                //MARK: Signup button
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.accentColor)
                    
                    Button(action: {}, label: {
                        Text("Sign up")
                            .foregroundColor(.red)
                    })
                }
                .font(.callout)
                .opacity(0.6)
            } // VStack Main
            .padding()
            
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
        } // Navigation View
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 8")
    }
}

// MARK: - Solution
/*
 📌 Use MVVM approach
 📌 Reuse input fields using EntryField file
 📌 Use of Combine for handle conditions
 📌 Use of RegEx for handle restrictions and Extensions file code for triming spaces in username field
 📌 Instructions are hidden when the validation is passed
 📌 Login button only activates if all conditions are complete
 */


// MARK: - Copyright notice
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish, distribute, sublicense, create a derivative work, and/or sell copies of the Software in any work that is designed, intended, or marketed for pedagogical or instructional purposes related to programming, coding, application development, or information technology.  Permission for such use, copying, modification, merger, publication, distribution, sublicensing, creation of derivative works, or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
