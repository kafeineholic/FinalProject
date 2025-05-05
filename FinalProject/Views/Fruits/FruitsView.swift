//
//  FruitsView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct FruitsView: View {
	@StateObject var viewModel = FruitsViewModel()
	
	var body: some View {
		VStack {
			if viewModel.isLoading {
				ProgressView()
			} else {
				CardSwiperView(items: $viewModel.fruits) { fruit in
					VStack {
						Text(fruit.english)
							.font(.largeTitle)
						Text(fruit.thai)
							.font(.title2)
						Text(fruit.japanese)
							.font(.title3)
					}
				}

			}
		}
		.onAppear {
			viewModel.loadFruits()
		}
	}
}
