//
//  MainContentView.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 27/1/22.
//

import SwiftUI

struct MainContentView: View {
    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(1)
            
            DashBoardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("DashBoard")
                }
                .tag(2)
            
            CartItemView()
                .tabItem {
                    Image(systemName: "cart.badge.plus")
                        Text("Cart")
                }
                .tag(3)
            
            ContactView()
                .tabItem {
                    Image(systemName: "phone.circle")
                    Text("Contact")
                }
                .tag(4)
        }
        // MARK: - SELECTED TAB COLOR CHANGED
        .accentColor(.green)
        .background(Color.white)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
