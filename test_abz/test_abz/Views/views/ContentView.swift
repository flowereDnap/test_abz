//
//  ContentView.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State var isFullScreenPresented = false
    @State var alertTypeInvoked: AlertType = .noConnection
    
    @State var selectedTab: Tab = .users
    
    @StateObject var usersListVM: UsersListVM
    @StateObject var signUpVM: SignUpVM = SignUpVM()
    
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
                    
                    TabView(selection: $selectedTab) {
                        
                        UsersView(viewModel: usersListVM)
                            .tabItem {
                                Label("Users", systemImage: "person.3").labelStyle(hStyle())
                            }
                            .tag(ContentView.Tab.users)
                        
                        SignupView(viewModel: signUpVM)
                            .tabItem {
                                Label("Signup", systemImage: "person.badge.plus")
                            }
                            .tag(Tab.signup)
                    }
                    .fullScreenCover(isPresented: $isFullScreenPresented) {
                        ModalAlertView(type: alertTypeInvoked, supportingText: nil, isPresented: $isFullScreenPresented) {
                            
                        }
                    }
                    
                }
                
            }
            .padding(.top, proxy.safeAreaInsets.top > 0 ? 0.2 : 0)
            .onAppear(){
                usersListVM.isPresented = $isFullScreenPresented
                usersListVM.alertType = $alertTypeInvoked
            }
        }
    }
    
}

#Preview {
    ContentView(usersListVM: UsersListVM())
}
