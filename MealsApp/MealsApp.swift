//
//  MealsApp.swift
//  MealsApp
//
//  Created by Chris Scutt on 07/10/2024.
//

import SwiftUI

@main
struct MealsApp: App {
	@StateObject var coordinator = MainCoordinator()

    var body: some Scene {
        WindowGroup {
			let viewModel = coordinator.createMealsViewModel()
			MainView(viewModel: viewModel, coordinator: coordinator)
        }
    }
}
