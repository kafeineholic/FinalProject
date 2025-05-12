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
                } else if viewModel.fruits.isEmpty {
                    VStack(spacing: 20) {
                        Text("Play Again!")
                            .font(.title2)
                            .foregroundColor(.white)

                        Button(action: {
                            viewModel.loadFruits()
                        }) {
                            Image(systemName: "gobackward")
                                    .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.indigo)
                                        .clipShape(Circle())
                        }
                    }
                } else {
                    CardSwiperView(items: $viewModel.fruits) { fruit in
                        FruitsCardView(fruit: fruit)
                    }
                    .onSwiped { direction, fruit in
                        if let index = viewModel.fruits.firstIndex(where: { $0.id == fruit.id }) {
                            viewModel.fruits.remove(at: index)
                        }
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
