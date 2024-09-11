//
//  AlertVM.swift
//  test_abz
//
//  Created by mac on 03.09.2024.
//

import Foundation
import SwiftUI

class AlertVM: ObservableObject {
    @Published var type: AlertType = .noConnection
    @Published var isPresented: Bool = false
    @Published var supportingText: String? = nil
    @Published var complition: ()->Void = {}
}
