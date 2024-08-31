//
//  CustomTabView.swift
//  test_abz
//
//  Created by mac on 30.08.2024.
//

import Foundation
import SwiftUI

enum TabType: String, CaseIterable{
    case Users
    case SignUp = "Sign up"

    var titleKey: String {
        "\(self)".capitalized
    }
    
    var symbolName: String {
        switch self {
        case .Users: "person.3"
        case .SignUp: "person.badge.plus"
        }
    }
}

struct TabLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 4) {
            configuration.icon
                .dynamicTypeSize(.xxxLarge)
            configuration.title
                .font(.caption)
        }
    }
}

struct CustomTabBar: View {
    @Binding var selection: TabType

    var body: some View {
        HStack {
            ForEach(TabType.allCases, id: \.self) { type in
                Button {
                    withAnimation(.spring(duration: 0.2)) {
                        selection = type
                    }
                } label: {
                    Label(type.rawValue, systemImage: type.symbolName)
                        .labelStyle(TabLabelStyle())
                        .symbolVariant(selection == type ? .fill : .none)
                        .foregroundStyle(selection == type ? UIConstraints.secondary : UIConstraints.black60)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
        .background(.bar)
        .overlay(alignment: .top) { Divider() }
    }
}

struct ContentViewTV: View {
    @State private var selection = TabType.Users

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selection {
                case .Users: Text("1")
                case .SignUp: Text("2")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomTabBar(selection: $selection)
        }
    }
}

#Preview {
    ContentViewTV()
}
