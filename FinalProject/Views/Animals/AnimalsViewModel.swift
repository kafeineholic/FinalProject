import SwiftUI

class AnimalsViewModel: ObservableObject {
    @Published var animals: [AnimalItem] = []
    @Published var isLoading = false
    
    func loadAnimals() {
        isLoading = true
        if let loadedAnimals = AnimalsData.loadAsArray() {
            animals = loadedAnimals
        }
        isLoading = false
    }
}
