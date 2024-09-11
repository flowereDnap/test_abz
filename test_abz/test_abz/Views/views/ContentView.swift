//
//  ContentView.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var alertVM: AlertVM
    
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
                        .fullScreenCover(isPresented: $alertVM.isPresented) {
                        ModalAlertView(viewModel: alertVM)
                    }
                    
                }
                
            }
            .padding(.top, proxy.safeAreaInsets.top > 0 ? 0.2 : 0)
        }
    }
    
}


struct ContentView_P: PreviewProvider {
    struct Wrapper: View {
        @State private var isPresented: UIImage? = UIImage(named: "photo-cover")
        @StateObject var vm = AlertVM()
        
        var body: some View {
            
            ContentView(alertVM: vm, usersListVM: UsersListVM(alertVM: vm), signUpVM: SignUpVM(alertVM: vm))
            
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}

