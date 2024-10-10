//
//  NetworkClient.swift
//  MealsApp
//
//  Created by Chris Scutt on 07/10/2024.
//

import Foundation
import PromiseKit

protocol NetworkClient {
	func fetchMeal(from url: String) -> Promise<MealsResponse>
	func fetchMeals(from url: String) -> Promise<[String:[MealResponse]]>
	func fetchCategories(from url: String) -> Promise<[String:[CategoryResponse]]>
	func fetchFiltered(from url: String) -> Promise<FiltersResponse>
}

final class NetworkClientImpl: NetworkClient {
	let session: URLSession
	
	init(session: URLSession = URLSession.shared) {
		self.session = session
	}
	
	func fetchMeal(from url: String) -> Promise<MealsResponse> {
		return fetchData(from: url).then(decodeJSON)
	}
	
	func fetchMeals(from url: String) -> Promise<[String:[MealResponse]]> {
		return fetchData(from: url).then(decodeJSON)
	}
	
	func fetchCategories(from url: String) -> Promise<[String:[CategoryResponse]]> {
		return fetchData(from: url).then(decodeJSON)
	}
	
	func fetchFiltered(from url: String) -> Promise<FiltersResponse> {
		return fetchData(from: url).then(decodeJSON)
	}
	
	private func fetchData(from urlString: String) -> Promise<Data> {
		guard let url = URL(string: urlString) else {
			return Promise(error: NetworkError.invalidURL)
		}
		return Promise { seal in
			let task = URLSession.shared.dataTask(with: url) { data, response, error in
				if let error = error {
					seal.reject(error)
				} else if let data = data {
					seal.fulfill(data)
				}
			}
			task.resume()
		}
	}
	
	private func decodeJSON<T: Decodable>(data: Data) -> Promise<T> {
		return Promise { seal in
			do {
				let decodedData = try JSONDecoder().decode(T.self, from: data)
				seal.fulfill(decodedData)
			} catch {
				seal.reject(error)
			}
		}
	}
}
