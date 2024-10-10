//
//  CategoryThumbView.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import SwiftUI

struct CategoryThumbView: View {
	let category: Category

	var body: some View {
		VStack {
			AsyncImage(url: category.thumb) { image in
				image
					.resizable()
					.scaledToFit()
			} placeholder: {
				ProgressView()
					.background(Color.gray.opacity(0.2))
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
					.aspectRatio(nil, contentMode: .fit)
					.clipped()
			}
			.accessibilityLabel("\(category.displayText) category image")
			
			Text(category.displayText)
				.font(.subheadline)
		}
	}
}
