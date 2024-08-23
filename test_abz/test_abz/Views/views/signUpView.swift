//
//  signUpView.swift
//  test_abz
//
//  Created by mac on 21.08.2024.
//

import Foundation
import SwiftUI

struct SignupView: View {
    //TODO VM
    
    var body: some View {
        VStack{
            //TextField(text: <#T##Binding<String>#>, label: <#T##() -> View#>)
            //TextField(text: Binding<String>, label: <#T##() -> View#>)
            //TextField(text: Binding<String>, label: <#T##() -> View#>) TODO bind to VM
            Text("Select your position").font(UIConstraints.fontRegular(size: 18))
            //TODO picker
            Button {
                
            } label: {
                Text("Sign Up")
            }.buttonStyle(PrimaryButtonStyle())
            
        }
    }
}


struct ContentView_Previews4: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

