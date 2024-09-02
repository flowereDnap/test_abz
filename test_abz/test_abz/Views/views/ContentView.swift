//
//  ContentView.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State var isFullScreenPresented = false
    @State var alertView: ModalAlertView = ModalAlertView( isPresented: nil) {
        
    }
    
    @State var selectedTab = TabType.Users
    
    @StateObject var usersListVM: UsersListVM
    @StateObject var signUpVM: SignUpVM
    
    enum Tab {
        case users
        case signup
    }
    
    
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                VStack{
                    Text(selectedTab == .Users ? "Working with GET request" : "Working with POST request")
                        .font(UIConstraints.fontRegular(size: 20))
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(UIConstraints.primary)
                    
                    
                    ZStack {
                        switch selectedTab {
                        case .Users: UsersView(viewModel: usersListVM).environmentObject(usersListVM)
                        case .SignUp:  SignupView(viewModel: signUpVM).environmentObject(signUpVM)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    CustomTabBar(selection: $selectedTab)
                    .fullScreenCover(isPresented: $isFullScreenPresented) {
                        alertView
                    }
                    
                }
                
            }
            .padding(.top, proxy.safeAreaInsets.top > 0 ? 0.2 : 0)
            .onAppear(){
                alertView.isPresented = $isFullScreenPresented
                usersListVM.alertView = $alertView
                signUpVM.alertView = $alertView
            }
        }
    }
    
}

#Preview {
    ContentView(usersListVM: UsersListVM(), signUpVM: SignUpVM())
}
