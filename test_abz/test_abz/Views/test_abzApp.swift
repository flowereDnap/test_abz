//
//  test_abzApp.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import SwiftUI

@main
struct test_abzApp: App {
    var body: some Scene {
        WindowGroup {
            
            ContentView( usersListVM: UsersListVM(), signUpVM: SignUpVM())
        }
    }
}
