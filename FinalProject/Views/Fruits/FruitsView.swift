//
//  FruitsView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct FruitsView: View {
	@StateObject var viewModel = FruitsViewModel()
	@Environment(\.dismiss) var dismiss
	var body: some View {
		ZStack{
			Image("background03")
				.resizable()
				.aspectRatio(contentMode: ContentMode.fill)
				.opacity(0.7)
				.ignoresSafeArea()
			VStack {
				if viewModel.isLoading {
					ProgressView()
				} else {
					CardSwiperView(items: $viewModel.fruits) { fruit in
						FruitsCardView(fruit: fruit)
					}
				}
			}
		}
		.onAppear {
			viewModel.loadFruits()
		}
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					dismiss()
				}) {
					Image("homeIcon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 50, height: 50)
						.padding(8)
				}
			}
		}
	}
}
