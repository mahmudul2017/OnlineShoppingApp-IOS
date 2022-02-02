//
//  ProfileView.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 27/1/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    coverImageView
                    
                    profileImageView
                        .offset(y: -80)
                        .padding(.bottom, -70)
                    
                    profileNameView
                        .padding(.bottom, 32)
                    
                    Group {
                        profileBalanceView
                        Divider()
                            .padding(.trailing, -16)
                        profileEmailView
                            .padding(.top, 6)
                        Divider()
                            .padding(.trailing, -16)
                        profilePhoneView
                            .padding(.top, 6)
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    
                    Divider()
                        .padding(.leading, 64)
                        .padding(.trailing, 64)
                    
                    profileAddressView
                        .padding(.top, 16)
                    
                    Spacer()
                }
                .background(Color.white)
                .navigationBarTitle(Text("Profile"), displayMode: .inline)
                .navigationBarItems(leading: profileRefreshView)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    var profileImageView: some View {
        VStack {
            Circle()
                .fill(Color.white)
                .frame(width: 100, height: 100)
                .overlay(
                    Image("profile_avater")
                        .resizable()
                        .padding(6)
                        .frame(width: 80, height: 80))
                .shadow(radius: 5)
        }
    }
    
    var coverImageView: some View {
        VStack {
            Image("profile_cover")
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 130)
        }
    }
    
    var profileNameView: some View {
        VStack {
            Text("Md. Mahmudul Hasan")
                .font(.system(size: 18))
                .bold()
        }
    }
    
    var profileBalanceView: some View {
        HStack(alignment: .center) {
            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 17, weight: .regular))
                .imageScale(.large)
                .padding(.trailing, 5)
                .foregroundColor(Colors.color2)
            
            Text("Balance")
                .bold()
                .font(.system(size: 17))
                .font(.title)
                .foregroundColor(Colors.color2)
            
            Spacer()
            
            Text("700.0")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(Color.gray)
        }
        .padding(.bottom, 6)
    }
    
    var profileEmailView: some View {
        HStack(alignment: .center) {
            Image(systemName: "envelope.fill")
                .font(.system(size: 17, weight: .regular))
                .imageScale(.large)
                .padding(.trailing, 5)
                .foregroundColor(Colors.color2)
            
            Text("Email")
                .bold()
                .font(.system(size: 17))
                .font(.title)
                .foregroundColor(Colors.color2)
            
            Spacer()
            
            Text("mahmudulcse15@gmail.com")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(Color.gray)
        }.padding(.bottom, 6)
    }
    
    var profilePhoneView: some View {
        HStack(alignment: .center) {
            Image(systemName: "phone.fill")
                .font(.system(size: 17, weight: .regular))
                .imageScale(.large)
                .padding(.trailing, 5)
                .foregroundColor(Colors.color2)
            
            Text("Phone")
                .bold()
                .font(.system(size: 17))
                .font(.title)
                .foregroundColor(Colors.color2)
            
            Spacer()
            
            Text("+880-01749367535")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(Color.gray)
        }.padding(.bottom, 6)
    }
    
    var profileAddressView: some View {
        VStack(alignment: .center) {
            Text("Address")
                .bold()
                .font(.system(size: 17))
                .font(.title)
                .foregroundColor(Colors.color2)
            
            Text("H-80/81, Dokkhin Goran, Dhaka-1230")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(Color.gray)
                .padding(.top, 2)
        }
    }
    
    var profileRefreshView: some View {
        Button(action: {
            //self.viewModel.refreshUI()
        }) {
            Image(systemName: "arrow.clockwise")
                .font(.system(size: 18, weight: .light))
                .imageScale(.large)
                .accessibility(label: Text("Refresh"))
                .foregroundColor(Colors.greenTheme)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
