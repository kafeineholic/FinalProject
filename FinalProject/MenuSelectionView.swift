//
//  GamesView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct MenuSelectionView: View {
	@Environment(\.dismiss) var dismiss
	@State private var selectedCategory: String? = nil

	var body: some View {
		NavigationStack {
			ZStack {
				Image("background02")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
				VStack(spacing: 24) {
					Spacer().frame(height: 30)

					// ปุ่ม Flashcard
					MenuButton(imageName: "flashcardButton", title: "Flashcard", selectedCategory: $selectedCategory, destination: destinationForFlashcard())

					// ปุ่ม Quiz
					MenuButton(imageName: "quizButton", title: "Quiz", selectedCategory: $selectedCategory, destination: destinationForQuiz())

					// ปุ่ม Scan
					MenuButton(imageName: "scanButton", title: "Scan", selectedCategory: $selectedCategory, destination: destinationForScan())

					Spacer()
				}
				.padding(.horizontal)
			}
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: {
						dismiss()
					}) {
						Image(systemName: "house.circle.fill")
							.font(.system(size: 40))
							.foregroundStyle(.white, .blue)
							.padding()
					}
				}
			}
		}
	}

	
	func destinationForFlashcard() -> AnyView {
		if let category = selectedCategory {
			if category == "Fruit" {
				return AnyView(FruitsView())
			} else if category == "Animal" {
				return AnyView(AnimalsView())
			}
		}
		return AnyView(EmptyView())
	}

	
	func destinationForQuiz() -> AnyView {
		if let category = selectedCategory {
			if category == "Fruit" {
				return AnyView(FruitQuizView(gameManagerVM: GameManagerVM(category: .fruits)))
			} else if category == "Animal" {
				return AnyView(AnimalQuizView(gameManagerVM: GameManagerVM(category: .animals)))
			}
		}
		return AnyView(EmptyView())
	}

	
	func destinationForScan() -> AnyView {
		if let category = selectedCategory {
			if category == "Fruit" {
				return AnyView(CameraFruitsView())
			} else if category == "Animal" {
				return AnyView(CameraAnimalsView())
			}
		}
		return AnyView(EmptyView())
	}
}

struct MenuButton: View {
	let imageName: String
	let title: String
	@Binding var selectedCategory: String?
	let destination: AnyView  

	var body: some View {
		NavigationLink(destination: destination) {
			ZStack {
				Image(imageName)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 250, height: 120)
					.saturation(0.95)
					.clipShape(RoundedRectangle(cornerRadius: 25))
					.shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
				
				Text(title)
					.font(.system(size: 28, weight: .bold))
					.foregroundColor(.white)
					.shadow(radius: 3)
			}
		}
	}
}

#Preview {
	MenuSelectionView()
}
