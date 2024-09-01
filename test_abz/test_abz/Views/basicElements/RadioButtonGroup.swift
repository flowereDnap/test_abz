//
//  RadioButtonGroup.swift
//  test_abz
//
//  Created by mac on 23.08.2024.
//

import Foundation
import SwiftUI

protocol RadioButtonItem {
    var id: Int { get set }
    var name: String { get set }
}

struct RadioButtonGroup<T: RadioButtonItem>: View {
    
    @Binding var items : [T]
    
    @State var selectedId: String = ""
    
    @State private var contentHeight: CGFloat = 0
    
    let callback: (String) -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(items, id: \.id) { item in
            RadioButton(item.name, callback: self.radioGroupCallback, selectedID: self.selectedId)
                    .padding(0)
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
        .padding(0)
    }
}



struct InputTextField_PreviewsRadio: PreviewProvider {
    struct Wrapper: View {
        
        @State var data = [
        Position(id: 1, name: "1"),
        Position(id: 1, name: "1"),
        Position(id: 1, name: "1")]
        
        var body: some View {
            ScrollView{
                RadioButtonGroup<Position>(items: $data, selectedId: "London") { selected in
                    
                }
                .frame(height: 200)
            }
        }
    }

    static var previews: some View {
        Wrapper()
    }
}
