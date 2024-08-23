//
//  UserCellView.swift
//  test_abz
//
//  Created by mac on 22.08.2024.
//

import Foundation

import SwiftUI

struct UserCellView: View {
    
    var user: User
    var image: UIImage = UIImage(imageLiteralResourceName: "photo-cover")
    
    
    
    var body: some View {
        HStack(alignment: .top){
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 16)
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

#Preview {
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
