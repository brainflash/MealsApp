//
//  FiltersRepository.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Foundation
import PromiseKit

protocol FiltersRepository {
	func filterBy(category: Category) -> Promise<[FilterResult]>
}
