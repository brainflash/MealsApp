//
//  MealListItem.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import SwiftUI

struct MealListItem: View {
	let meal: Meal

	var body: some View {
		HStack {
			AsyncImage(url: meal.thumb) { image in
				image
					.resizable()
					.scaledToFill()
			} placeholder: {
				ProgressView()
					.frame(width: 50, height: 50)
					.background(Color.gray.opacity(0.2))
			}
			.accessibilityLabel("\(meal.name) image")
			.frame(width: 50, height: 50)
			.clipped()
			
			Text(meal.name)
				.font(.body)
		}
	}
}
