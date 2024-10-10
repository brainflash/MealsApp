//
//  MealsViewModel.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Combine
import Foundation
import PromiseKit
import SwiftUI

class MealsViewModel: ObservableObject {
	@Published var query: String = ""
	@Published var results: [Meal] = []
	@Published var isSearching: Bool = true
	
	private var fetchRandomMealUseCase: FetchRandomMealUseCase
	private var searchForMealUseCase: SearchForMealUseCase
	private var coordinator: MainCoordinator
	private var cancellables = Set<AnyCancellable>()
	
	init(fetchRandomMealUseCase: FetchRandomMealUseCase,
		 searchForMealUseCase: SearchForMealUseCase,
		 coordinator: MainCoordinator,
		 cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
		self.fetchRandomMealUseCase = fetchRandomMealUseCase
		self.searchForMealUseCase = searchForMealUseCase
		self.coordinator = coordinator
		self.cancellables = cancellables
		setupBindings()
	}
	
	func fetchRandomMeal() {
		fetchRandomMealUseCase.execute()
			.done { [weak self] result in
				self?.coordinator.navigateTo(meal: result)
			}
			.catch { error in
				print("fetchRandomMeal error: \(error)")
			}
	}

	private func setupBindings() {
		$query
			.debounce(for: .milliseconds(300), scheduler: RunLoop.main)
			.sink { [weak self] query in
				guard let self = self else { return }
				
				isSearching = !query.isEmpty
				guard isSearching else {
					clearSearchResults()
					return
				}
				search(query: query)
			}
			.store(in: &cancellables)
	}
	
	private func search(query: String) {
		searchForMealUseCase.execute(query: query)
			.done { [weak self] results in
				self?.results = results
			}
			.catch { [weak self] error in
				print("searchForMeal error: \(error)")
				self?.results = []
			}
	}
	
	private func clearSearchResults() {
		self.results = []
	}
}
