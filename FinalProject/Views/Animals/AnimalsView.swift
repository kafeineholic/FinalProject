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
                        Button(action: {
                            viewModel.loadAnimals()
                        }) {
							Image("button04")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 220, height: 80)
								.padding()
								.background(
									RoundedRectangle(cornerRadius: 40)
										.fill(Color(red: 255/255, green: 248/255, blue: 231/255))
										.shadow(color: Color.gray.opacity(0.2), radius: 6, x: 0, y: 4)
								)
								.overlay(
									RoundedRectangle(cornerRadius: 40)
										.stroke(Color.gray.opacity(0.5), lineWidth: 2))
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

