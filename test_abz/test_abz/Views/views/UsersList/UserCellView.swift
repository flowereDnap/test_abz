//
//  UserCellView.swift
//  test_abz
//
//  Created by mac on 22.08.2024.
//

import Foundation

import SwiftUI

struct UserCellView: View {
    
    @EnvironmentObject var viewModel: UsersListVM
    var user: User
    @State private var image: UIImage = UIImage(named: "photo-cover")!
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 0){
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.trailing, 16)
                    .onAppear {
                                        viewModel.fetchUserImage(for: user, bindingImage: $image)
                                    }
            VStack(alignment: .leading, spacing: 0){
                Text(user.name)
                        .font(UIConstraints.fontRegular(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(0)
                Text(user.position)
                        .font(UIConstraints.fontRegular(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(UIConstraints.black60)
                        .padding(.top, 4)
                Text(user.email)
                    .font(UIConstraints.fontRegular(size: 14))
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(UIConstraints.black87)
                    .padding(.top, 8)
                Text(user.phone)
                    .font(UIConstraints.fontRegular(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(0)
                }
                .frame(maxWidth: .infinity)
                .frame(alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
    }
}


struct ContentView_PreviewsUserList: PreviewProvider {
    struct Wrapper: View {
        @State private var isPresented: UIImage = UIImage(named: "photo-cover")!
        @StateObject var vm = AlertVM()

        var body: some View {
            
            UserCellView(user: User(id: 0,
                                    registrationTimestamp: 0,
                                    name:    "Seraphina Anastasia Isolde Aurelia Celestina von Hohenzollern",
                                    email:
                                    "maximus_wilderman_ronaldo_schuppe@gmail.com",
                                    phone: "+38 (098) 278 76 24",
                                    positionId: 1,
                                    position: "Backend developer",
                                    photo: "")
            )
            
        }
    }

    static var previews: some View {
        Wrapper()
    }
}
