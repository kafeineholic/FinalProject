//
//  FruitsViewModel.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 5/5/2568 BE.
//

import SwiftUI

class FruitsViewModel: ObservableObject {
	@Published var fruits: [FruitsData] = []
	@Published var isLoading = false
	
	func loadFruits() {
		isLoading = true
		DispatchQueue.global(qos: .userInitiated).async {
			let loadedData = FruitDataLoader.loadFruits()
			DispatchQueue.main.async {
				self.fruits = loadedData
				self.isLoading = false
			}
		}
	}
}
