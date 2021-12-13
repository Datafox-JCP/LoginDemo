//
//  ContentView.swift
//  LoginDemo
//
//  Created by Juan Carlos Pazos on 11/12/21.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel = LoginViewModel()
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            // MARK: Logo image
            Image("edvora")
                .padding()
            
            Spacer()
            
            //MARK: Username
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(Color("Icons"))
                    .font(.headline)
                TextField("Username", text: $viewModel.username)
                    .onChange(of: viewModel.username, perform: { value in
                        // Don't allow Uppercase and use the extension to trim spaces
                        viewModel.username = String(value.lowercased()).trim()
                    })
            } // HStack
            .padding(14)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Border"), lineWidth: 1)
                    .opacity(1)
            )
            .padding(4)
            
            //MARK: Password
            HStack {
                Image(systemName: "key.fill")
                    .foregroundColor(Color("Icons"))
                    .font(.headline)
                SecureField("Password", text: $viewModel.password)
                    .onChange(of: viewModel.password, perform: { value in
                        // Dont allow more than 8
                        viewModel.password = String(value.prefix(8))
                    })
                Button(action: {}, label: {
                    Image(systemName: "eye.fill")
                        .foregroundColor(Color("Border"))
                        .font(.headline)
                })
                
            } // HStack Password
            .padding(14)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Border"), lineWidth: 1)
                    .opacity(1)
            )
            .padding(4)
            
            //MARK: Email
            HStack {
                Image(systemName: "envelope.fill")
                    .foregroundColor(Color("Icons"))
                    .font(.headline)
                TextField("Email address", text: $viewModel.email)
                    .autocapitalization(.none)
                    .keyboardType(UIKeyboardType.emailAddress)
            } // HStack Email
            .padding(14)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Border"), lineWidth: 1)
                    .opacity(1)
            )
            .padding(4)
            
            //MARK: Forgotten
            HStack {
                Spacer()
                Button(action: {}, label: {
                Text("Forgotten password?")
                    .foregroundColor(Color("Border"))
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
            .background(Color("Color1"))
            .cornerRadius(8)
            .opacity(viewModel.canSubmit ? 1 : 0.6)
            .disabled(!viewModel.canSubmit)
            
            Spacer()
            
            //MARK: Signup button
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(Color("Icons"))
                    
                Button(action: {}, label: {
                    Text("Sign up")
                        .foregroundColor(Color("Border"))
                })
            }
            .font(.callout)
        } // VStack Main
        .padding()
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 mini")
    }
}
