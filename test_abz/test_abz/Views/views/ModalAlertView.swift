//
//  NoConnectionAlertView.swift
//  test_abz
//
//  Created by mac on 21.08.2024.
//

import Foundation
import SwiftUI

struct ModalAlertView: View {
    
    @State var message: Message
    
    enum Message {
        case noConnection
        case signUpSuccess
        case signUpFail
    }
    
    init(message: Message) {
        self.message = message
    }
    
    var body: some View {
        VStack {
            
            Text("default")
            Button {
                
            } label: {
                Text("Button")
            }
        }
    }
}

#Preview {
    ModalAlertView(message: .noConnection )
}
