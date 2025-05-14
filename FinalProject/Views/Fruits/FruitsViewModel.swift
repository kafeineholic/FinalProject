import SwiftUI

class FruitsViewModel: ObservableObject {
	@Published var fruits: [FruitItem] = []
	@Published var isLoading = false
	
	func loadFruits() {
		isLoading = true
		if let loadedFruits = FruitsData.loadAsArray() {
			fruits = loadedFruits
		}
		isLoading = false
	}
}
