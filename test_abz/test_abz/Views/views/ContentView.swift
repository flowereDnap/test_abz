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
    
    @State var selectedTab = TabType.Users
    
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
                    Text(selectedTab == .Users ? "Working with GET request" : "Working with POST request")
                        .font(UIConstraints.fontRegular(size: 20))
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(UIConstraints.primary)
                    
                    
                    ZStack {
                        switch selectedTab {
                        case .Users: UsersView(viewModel: usersListVM).environmentObject(usersListVM)
                        case .SignUp:  SignupView(viewModel: signUpVM, selectedImage: signUpVM.$photo).environmentObject(signUpVM)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    CustomTabBar(selection: $selectedTab)
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
