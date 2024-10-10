//
//  Coodinator.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import SwiftUI

protocol Coordinator {
	func start()
	func goBack()
	func navigateTo(category: Category)
	func navigateTo(meal: Meal)
}
