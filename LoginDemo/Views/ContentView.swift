//
//  ContentView.swift
//  LoginDemo
//
//  Created by Juan Carlos Pazos on 11/12/21.
//

import SwiftUI

struct ContentView: View {
    // Properties
    @StateObject private var viewModel = LoginViewModel()
    
    // View
    var body: some View {
        VStack {
            Image("edvora")
                .padding()
            
            Spacer()
            
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(Color("Icons"))
                    .font(.headline)
                TextField("Username", text: $viewModel.username)
            }
            .padding(14)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Border"), lineWidth: 1)
                    .opacity(1)
            )
            .padding(4)
            
            HStack {
                Image(systemName: "key.fill")
                    .foregroundColor(Color("Icons"))
                    .font(.headline)
                TextField("Password", text: $viewModel.password)
            }
            .padding(14)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Border"), lineWidth: 1)
                    .opacity(1)
            )
            .padding(4)
            
            HStack {
                Image(systemName: "envelope.fill")
                    .foregroundColor(Color("Icons"))
                    .font(.headline)
                TextField("Email address", text: $viewModel.email)
            }
            .padding(14)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Border"), lineWidth: 1)
                    .opacity(1)
            )
            .padding(4)
            
            HStack {
                Spacer()
                Text("Forgotten password?")
                    .foregroundColor(Color("Border"))
                    .font(.callout)
            }
            .padding(4)
            
            
            Spacer()
            
            Button {
                viewModel.login()
            } label: {
                Text("LOGIN")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding(EdgeInsets(top: 10, leading: 110, bottom: 10, trailing: 110))
            .foregroundColor(.white)
            .background(Color("Color1"))
            .cornerRadius(8)
            .opacity(viewModel.canSubmit ? 1 : 1)
            .disabled(!viewModel.canSubmit)
            
            Spacer()
            
            Button(action: {}, label: {
                Text("Don't have an account?")
                    .foregroundColor(Color("Icons"))
                    .font(.callout)
                Text("Sign up")
                    .foregroundColor(Color("Border"))
                    .font(.callout)
            })
            
        } // VStack
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
