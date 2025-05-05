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
					FruitsCardView(fruit: fruit)
				}
			}
		}
		.onAppear {
			viewModel.loadFruits()
		}
	}
}
