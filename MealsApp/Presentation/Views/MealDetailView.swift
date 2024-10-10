//
//  MealDetailView.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import SwiftUI

struct MealDetailView: View {
	@StateObject var viewModel: MealDetailViewModel
	@ObservedObject var coordinator: MainCoordinator
	@State var showIngredients: Bool = false
	
	var body: some View {
		VStack {
			let imageWidth: CGFloat = 300, imageHeight: CGFloat = 300
			AsyncImage(url: viewModel.meal.thumb) { image in
				image
					.resizable()
					.scaledToFill()
			} placeholder: {
				ProgressView()
					.frame(width: imageWidth, height: imageHeight)
					.background(Color.gray.opacity(0.2))
			}
				.accessibilityLabel("Meal image")
				.frame(width: imageWidth, height: imageHeight)
				.padding()
				.clipped()
			
			Spacer()
			
			Text(viewModel.meal.name)
				.font(.headline)

			Spacer()
			
			Button(action: {
				showIngredients = true
			}) {
				Text("Ingredients")
			}
			
			ScrollView {

				Text(viewModel.meal.instructions)
					.padding()
				
				Spacer()
				
				if let url = viewModel.meal.youTube {
					Link("YouTube video", destination: url)
						.onTapGesture {
							UIApplication.shared.open(url)
						}
				}
			}
			
			Spacer()
		}
		.onAppear {
			viewModel.fetchMeal()
		}
		.sheet(isPresented: $showIngredients) {
			IngredientsView(meal: viewModel.meal)
		}
	}
}
