//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Kyle Wilson on 2023-05-30.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    let firstName = UserDefaults.standard.string(forKey: "first name key")
    let lastName = UserDefaults.standard.string(forKey: "last name key")
    let email = UserDefaults.standard.string(forKey: "email key")
    let isLoggedIn = UserDefaults.standard.string(forKey: "IsLoggedIn key")
    
    @State var orderStatuses = false
    @State var passwordChanges = false
    @State var specialOffers = false
    @State var newsletter = false
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Personal Information")
                        .font(.title)
                        .bold()
                    .padding(.bottom, 5)
                    Text("Avatar")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.leading, 5)
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Image("Profile")
                        .resizable()
                        .scaledToFit()
                    Button {
                        print("Change Profile Image")
                    } label: {
                        Text("Change")
                            .foregroundColor(.white)
                            .frame(width: 80, height: 40)
                            .background(Color("Hero-Background"))
                            .cornerRadius(5)
                    }
                    Button {
                        print("Remove Profile Image")
                    } label: {
                        Text("Remove")
                            .foregroundColor(.gray)
                            .frame(width: 80, height: 40)
                            .background(.white)
                            .cornerRadius(5)
                            .border(Color("Hero-Background"))
                    }
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                Text("First name")
                    .foregroundColor(.black)
                    .font(.footnote)
                .bold()
                Text(firstName ?? "")
                    .frame(width: 350, height: 50)
                    .border(.gray)
                Text("Last name")
                    .foregroundColor(.black)
                    .font(.footnote)
                    .bold()
                Text(lastName ?? "")
                    .frame(width: 350, height: 50)
                    .border(.gray)
                Text("Email")
                    .foregroundColor(.black)
                    .font(.footnote)
                    .bold()
                Text(email ?? "")
                    .frame(width: 350, height: 50)
                    .border(.gray)
            }
            
            
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Email Notifications")
                        .font(.title2)
                    .bold()
                    Button {
                        orderStatuses.toggle()
                        print("order statuses: \(orderStatuses)")
                    } label: {
                        Label("Order statuses", systemImage: orderStatuses ? "checkmark.square.fill" : "square")
                            .foregroundColor(Color("Hero-Background"))
                    }
                    Button {
                        passwordChanges.toggle()
                        print("password changes: \(passwordChanges)")
                    } label: {
                        Label("Password changes", systemImage: passwordChanges ? "checkmark.square.fill" : "square")
                            .foregroundColor(Color("Hero-Background"))
                    }
                    Button {
                        specialOffers.toggle()
                        print("special offers: \(specialOffers)")
                    } label: {
                        Label("Special offers", systemImage: specialOffers ? "checkmark.square.fill" : "square")
                            .foregroundColor(Color("Hero-Background"))
                    }
                    Button {
                        newsletter.toggle()
                        print("newsletter: \(newsletter)")
                    } label: {
                        Label("Newsletter", systemImage: newsletter ? "checkmark.square.fill" : "square")
                            .foregroundColor(Color("Hero-Background"))
                    }
                }
                Spacer()
            }
            .padding(.top, 5)
            .padding(.bottom, 10)
            
            Button {
                UserDefaults.standard.set(false, forKey: "IsLoggedIn key")
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Log out")
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 370, height: 40)
                    .background(Color("Little-Lemon"))
                    .border(Color("Hero-Background"))
            }
            HStack {
                Button {
                    print("Discard changes")
                } label: {
                    Text("Discard changes")
                        .foregroundColor(.gray)
                        .bold()
                        .frame(width: 180, height: 40)
                        .background(.white)
                        .cornerRadius(5)
                        .border(Color("Hero-Background"))
                }
                Button {
                    print("Discard changes")
                } label: {
                    Text("Save changes")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 180, height: 40)
                        .background(Color("Hero-Background"))
                        .cornerRadius(5)
                }
            }
        }
        .padding()
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
