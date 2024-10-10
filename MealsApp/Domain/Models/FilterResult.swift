//
//  FilterResult.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Foundation

struct FilterResult: Identifiable, Equatable {
	let id: String
	let meal: String
	let thumb: URL?
}
