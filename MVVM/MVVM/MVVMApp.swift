//
//  MVVMApp.swift
//  MVVM
//
//  Created by Matheus de Sousa Matos on 28/11/21.
//

import SwiftUI

@main
struct MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            ProfileView()
                .environmentObject(ProfileViewModel())
        }
    }
}
