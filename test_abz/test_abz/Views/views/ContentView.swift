//
//  ContentView.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isFullScreenPresented = false
    @State private var allertTypeInvoked: AllertType = .noConnection
    
    @State private var selectedTab: Tab = .users
    
    enum Tab {
        case users
        case signup
    }
    
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                VStack{
                    Text(selectedTab == .users ? "Working with GET request" : "Working with POST request")
                        .font(UIConstraints.fontRegular(size: 20))
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(UIConstraints.primary)
                    TabView {
                        
                        UsersView(list: [])
                            .tabItem {
                                Label("Users", systemImage: "person.3")
                            }
                            .tag(Tab.users)
                        
                        SignupView()
                            .tabItem {
                                Label("Signup", systemImage: "person.badge.plus")
                            }
                            .tag(Tab.signup)
                    }
                    .fullScreenCover(isPresented: $isFullScreenPresented) {
                        ModalAlertView(type: allertTypeInvoked, supportingText: nil, isPresented: $isFullScreenPresented) {
                            
                        }
                    }
                    
                }
            }
            .padding(.top, proxy.safeAreaInsets.top > 0 ? 0.2 : 0)
        }
    }
    
}

#Preview {
    ContentView()
}
