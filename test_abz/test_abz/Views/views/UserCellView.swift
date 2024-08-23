//
//  UserCellView.swift
//  test_abz
//
//  Created by mac on 22.08.2024.
//

import Foundation

import SwiftUI

struct UserCellView: View {
    
    //var user: User
    
    var body: some View {
        HStack(alignment: .top){
                Image("photo-cover")
                    .background(.green)
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 16)
                VStack(alignment: .leading){
                    Text("name")
                        .font(UIConstraints.fontRegular(size: 18))
                        
                        .background(.blue)
                    Text("position")
                        .background(.blue)
                    Text("email")
                    Text("ph#")
                }
                .frame(maxWidth: .infinity)
                .frame(alignment: .leading)
                .background(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
    }
}

#Preview {
    UserCellView()
}
