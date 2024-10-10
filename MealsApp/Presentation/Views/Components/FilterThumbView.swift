//
//  MealThumbView.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import SwiftUI

struct FilterThumbView: View {
	let result: FilterResult

	var body: some View {
		VStack {
			let width = 150.0, height = 150.0
			AsyncImage(url: result.thumb) { image in
				image
					.resizable()
					.scaledToFill()
			} placeholder: {
				ProgressView()
					.frame(width: width, height: height)
					.background(Color.gray.opacity(0.2))
			}
			.accessibilityLabel("\(result.meal) image")
			.frame(width: width, height: height)
			.clipped()
			
			Text(result.meal)
				.font(.subheadline)
		}
	}
}
