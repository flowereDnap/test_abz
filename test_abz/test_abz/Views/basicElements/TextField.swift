//
//  TextField.swift
//  test_abz
//
//  Created by mac on 20.08.2024.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    
    var subText: String = " "
    
    @Binding var validationResult: (Bool, String)
    
    var placeholder: String
    
    
    @Binding var text: String {
        didSet{
            if !isEditing {
                isFilled = !text.isEmpty
            }
        }
    }
    
    
    @State var isEditing: Bool = false
    @State var isFilled: Bool = false
    
    var placeholderColor: Color {
        if isFilled && !validationResult.0  { return .red }
        if (!isFilled && isEditing) { return UIConstraints.secondary }
        return UIConstraints.black60
    }
    var borderColor: Color {
        if !validationResult.0 && isFilled {return .red}
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
                        self.isFilled = (!text.isEmpty && !isEditing)
                    }
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
            .animation(.default, value: (validationResult.0 && isFilled))
            .padding(0)
            
            Text(  (!validationResult.0 && !isEditing && isFilled)  ?  validationResult.1 : subText )
                .frame(height: 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .foregroundColor((!validationResult.0 && !isEditing && isFilled) ?  .red : UIConstraints.black60)
                .font(UIConstraints.fontRegular(size: 14))
            
        }
    }
}



struct InputTextField_Previews: PreviewProvider {
    struct Wrapper: View {
        
        @State var text:String = ""
        @State private var validationResult: (Bool,String) = (true, "error")

        var body: some View {
            CustomTextField(
                subText: "promt",
                validationResult: $validationResult,
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
