//
//  SwiftUIView.swift
//  LittleLemon
//
//  Created by Kyle Wilson on 2023-05-30.
//

import SwiftUI

struct Onboarding: View {
    
    @State var isLoggedIn = false
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    let kFirstName = "first name key"
    let kLastName = "last name key"
    let kEmail = "email key"
    let kIsLoggedIn = "IsLoggedIn key"
    
    var body: some View {
        NavigationStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
            VStack(spacing: 25) {
                TextField("First Name", text: $firstName)
                    .padding()
                    .border(.black)
                TextField("Last Name", text: $lastName)
                    .padding()
                    .border(.black)
                TextField("Email", text: $email)
                    .padding()
                    .border(.black)
                    .keyboardType(.emailAddress)
                Button {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        isLoggedIn = true
                        UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
                    } else {
                        isLoggedIn = false
                    }
                } label: {
                    Text("Register")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 360, height: 40)
                        .background(Color("Hero-Background"))
                        .cornerRadius(5)
                }

            }.padding()
                .onAppear {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                        isLoggedIn = true
                    }
                }
                
                .navigationDestination(isPresented: $isLoggedIn) {
                    Home()
                }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
