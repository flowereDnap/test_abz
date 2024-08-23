//
//  usersListView.swift
//  test_abz
//
//  Created by mac on 21.08.2024.
//

import Foundation
import SwiftUI


struct UsersView: View {
    //@ObservedObject
    var list: [User] 
    
    var body: some View {
        VStack(spacing: 0) {
            if list.count == 0 {
                Image("no-users-image")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("There are no users yet")
                    .font(UIConstraints.fontRegular(size: 20))
            } else {
                List(list) { user in
                            UserCellView(user: user)
                        }
                .listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

#Preview {
    UsersView(list: [User(id: 0,
                          registrationTimestamp: 0,
                          name:    "Seraphina Anastasia Isolde Aurelia Celestina von Hohenzollern",
                          email:
                          "maximus_wilderman_ronaldo_schuppe@gmail.com",
                          phone: "+38 (098) 278 76 24",
                          positionId: 1,
                          position: "Backend developer",
                          photo: "")])
}
