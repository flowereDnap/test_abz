//
//  TextField.swift
//  test_abz
//
//  Created by mac on 20.08.2024.
//

import Foundation
import SwiftUI

struct TextInputField: View {
    
    var title: String
    var subText: String = " "
    let validate: (String)-> (Bool, String)
    var placeholder: String
    
    @State var errorMessage: String = ""
    
    @Binding var text: String
    
    @State var isEditing: Bool = false
    @State var error: Bool = false
    @State var isFilled: Bool = false
    
    var placeholderColor: Color {
        if error { return .red }
        if (!isFilled && isEditing) { return UIConstraints.secondary }
        return UIConstraints.black60
    }
    var borderColor: Color {
        if error {return .red}
        if isEditing {return UIConstraints.secondary}
        return Color(red: 0.81, green: 0.81, blue: 0.81)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .offset(x: 0, y: (!isEditing && !isFilled) ? 0 : -14)
                    .padding()
                    .font(UIConstraints.fontRegular(size: (isEditing || isFilled) ? 12 : 16))
                
                TextField("", text: $text, onEditingChanged: { isEditing in
                    withAnimation(.default) {
                        self.isEditing = isEditing
                        self.isFilled = !text.isEmpty
                    }
                    
                    
                    
                    if !isEditing {
                        
                        let result = validate(text)
                        error = !result.0
                        errorMessage = result.1
                    }
                    print(validate(text))
                })
                .font(UIConstraints.fontRegular(size: 16))
                .offset(x: 0, y: (!isEditing && !isFilled) ? 0 : 6)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(borderColor, lineWidth: isEditing ? 2 : 1)
                )
                
            }
            .frame(height: 56)
            .animation(.default, value: error)
            .padding(0)
            
            Text( error ? errorMessage : subText )
                .frame(height: 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .foregroundColor(error ? .red : UIConstraints.black60)
                .font(UIConstraints.fontRegular(size: 14))
            
        }
    }
}



struct InputTextField_Previews: PreviewProvider {
    struct Wrapper: View {
        @State private var text: String = ""
        @State private var valid: Bool = true

        var body: some View {
            TextInputField(
                title: "",
                subText: "promt",
                validate: { return ($0 == "aboba", "invalid")},
                placeholder:  "placeholder",
                text: $text
            )
            .padding()
        }
    }

    static var previews: some View {
        Wrapper()
    }
}
