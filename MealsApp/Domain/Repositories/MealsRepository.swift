//
//  MealsRepository.swift
//  MealsApp
//
//  Created by Chris Scutt on 07/10/2024.
//

import Foundation
import PromiseKit

protocol MealsRepository {
	func getRandomMeal() -> Promise<Meal>
	func getMeal(with id: String) -> Promise<Meal>
	func searchForMealsBy(query: String) -> Promise<[Meal]>
}
