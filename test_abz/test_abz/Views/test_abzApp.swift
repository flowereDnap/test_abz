//
//  test_abzApp.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import SwiftUI

@main
struct test_abzApp: App {
    @StateObject var alerVM = AlertVM()
    
    var body: some Scene {
        WindowGroup {
            
            ContentView(alertVM: alerVM, usersListVM: UsersListVM(alertVM: alerVM), signUpVM: SignUpVM(alertVM: alerVM))
        }
    }
}
