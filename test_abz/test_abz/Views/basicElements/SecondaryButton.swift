//
//  SecondaryButton.swift
//  test_abz
//
//  Created by mac on 20.08.2024.
//



import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .frame(width: 120)
            .background(
                configuration.isPressed ? UIConstraints.secondary.opacity(0.1) :
                    Color.clear
            )
            .foregroundColor(isEnabled ? UIConstraints.secondaryDark : UIConstraints.black48)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .opacity(isEnabled ? 0.6 : 1.0)
    }
}

struct bttTest2: View {
    @State private var isButtonDisabled = false

    var body: some View {
        VStack(spacing: 20) {
            // Normal State
            Button(action: {
                // Normal button action
            }) {
                
                Text("Normal")
                    
            }
            .buttonStyle(SecondaryButtonStyle())
            
            // Disabled State
            Button(action: {
                // Disabled button action
            }) {
                Text("Disabled")
            }
            .buttonStyle(SecondaryButtonStyle())
            .disabled(true)
            
        }
        .padding()
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        bttTest2()
    }
}
