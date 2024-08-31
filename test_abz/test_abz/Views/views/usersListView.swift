//
//  usersListView.swift
//  test_abz
//
//  Created by mac on 21.08.2024.
//

import Foundation
import SwiftUI


struct UsersView: View {
    
    @ObservedObject var viewModel: UsersListVM
    
    
    var body: some View {
        
        VStack(spacing: 24) {
            if viewModel.users.count == 0 {
                Image("no-users-image")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("There are no users yet")
                    .font(UIConstraints.fontRegular(size: 20))
                Button {
                    viewModel.fetchNextPage()
                    print("pressed")
                } label: {
                    Text("Reload")
                        .font(UIConstraints.fontRegular(size: 20))
                }.buttonStyle(PrimaryButtonStyle())
                
            } else {
                
                
                
                List(viewModel.users) { user in
 
                    UserCellView(user: user)
                }
                
                .listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
            }
        }
    }
}




struct UsersView_Previews: PreviewProvider {
    struct Wrapper: View {
        @State private var isPresented: Bool = false
        @State private var allertType: AlertType = .noConnection
        
        var body: some View {
            UsersView(viewModel: UsersListVM(isPresented: $isPresented, alertType: $allertType))
        }
    }
    
    static var previews: some View {
        Wrapper().environmentObject(UsersListVM())
    }
}
