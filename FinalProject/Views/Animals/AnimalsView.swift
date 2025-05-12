import SwiftUI

struct AnimalsView: View {
    @StateObject var viewModel = AnimalsViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Image("background03")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.7)
                .ignoresSafeArea()

            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.animals.isEmpty {
                    VStack(spacing: 20) {
                        Text("Restart!")
                            .font(.title2)
                            .foregroundColor(.white)

                        Button(action: {
                            viewModel.loadAnimals()
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
                    CardSwiperView(items: $viewModel.animals) { animal in
                        AnimalsCardView(animal: animal)
                    }
                    .onSwiped { direction, animal in
                        if let index = viewModel.animals.firstIndex(where: { $0.id == animal.id }) {
                            viewModel.animals.remove(at: index)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadAnimals()
            }
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

