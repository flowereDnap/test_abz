//
//  RadioButtonGroup.swift
//  test_abz
//
//  Created by mac on 23.08.2024.
//

import Foundation
import SwiftUI

struct RadioButtonGroup: View {
    
    let items : [String]
    
    @State var selectedId: String = ""
    
    let callback: (String) -> ()
    
    var body: some View {
        VStack {
            ForEach(0..<items.count) { index in
                RadioButton(self.items[index], callback: self.radioGroupCallback, selectedID: self.selectedId)
            }
        }
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}


struct RadioButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let id: String
    let callback: (String)->()
    let selectedID : String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    
    init(
        _ id: String,
        callback: @escaping (String)->(),
        selectedID: String,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 14
    ) {
        self.id = id
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(self.selectedID == self.id ? "radio-button-selected" : "radio-button-unselected")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 17, height: 17)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(self.selectedID == self.id ? UIConstraints.secondary : .gray)
                    .padding(17)
                    
                Text(id)
                    .font(UIConstraints.fontRegular(size: 16))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(self.color)
    }
}


#Preview() {
    RadioButtonGroup(items: ["Rome", "London", "Paris", "Berlin", "New York"], selectedId: "London") { selected in
                    print("Selected is: \(selected)")
                }
}
