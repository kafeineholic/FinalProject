//
//  FruitsView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct FruitsView: View {
	@State private var cards: [AnyView] = []

	var body: some View {
		VStack {
			Text("Swipe Cards")
				.font(.title)
				.foregroundColor(.gray)

			Button {
				print("Resetting...")
				loadCards()
			} label: {
				HStack {
					Image(systemName: "arrow.clockwise.circle.fill")
					Text("Reset Cards")
				}
			}

			CardSwiperView<AnyView>(cards: self.$cards, onCardSwiped: { swipeDirection, index in
				// Handle swipe
			}, onCardDragged: { swipeDirection, index, offset in
				// Handle drag
			})
			.padding(.vertical, 20)
		}
		.onAppear {
			loadCards()
		}
	}
	
	private func loadCards() {
		let fruitData = loadFruitData()
		let newCards = fruitData.map { data in
			AnyView(
				RoundedRectangle(cornerRadius: 20)
					.fill(Color.white)
					.overlay(
						VStack(spacing: 10) {
							Image(systemName: "leaf.fill")
								.font(.system(size: 50))
								.foregroundColor(.green)
							Text(data.english)
								.font(.title)
								.bold()
							Text(data.thai)
								.multilineTextAlignment(.center)
								.font(.body)
								.foregroundColor(.gray)
						}
						.padding()
					)
					.shadow(color: .gray, radius: 5)
			)
		}
		cards = newCards
	}
	
	func loadFruitData() -> [FruitCardData] {
		guard let url = Bundle.main.url(forResource: "FruitTranslations", withExtension: "plist"),
			  let data = try? Data(contentsOf: url),
			  let plistArray = try? PropertyListDecoder().decode([FruitCardData].self, from: data)
		else {
			print("❌ Failed to load or parse plist")
			return []
		}
		return plistArray
	}
}

struct FruitCardData: Identifiable, Codable {
	var id = UUID()
	let english: String
	let thai: String
}

