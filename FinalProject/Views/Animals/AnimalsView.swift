import SwiftUI

struct AnimalsView: View {
    @StateObject var viewModel = AnimalsViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                CardSwiperView(items: $viewModel.animals) { animal in
                    AnimalCardView(animal: animal)
                }
            }
        }
        .onAppear {
            viewModel.loadAnimals()
        }
    }
}
