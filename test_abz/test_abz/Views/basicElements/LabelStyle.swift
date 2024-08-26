//
//  LabelStyle.swift
//  test_abz
//
//  Created by mac on 26.08.2024.
//

import Foundation
import SwiftUI

struct hStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.icon
            configuration.title
        }
    }
}

#Preview(body: {
    Label("Users", systemImage: "person.3").labelStyle(hStyle())
})
