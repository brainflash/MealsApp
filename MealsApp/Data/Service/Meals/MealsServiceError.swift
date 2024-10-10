//
//  MealsServiceError.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

enum MealsServiceError: Error, Equatable {
	case noMealsFound
	case decodingError
}
