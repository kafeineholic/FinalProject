import SwiftUI

struct MenuSelectionView: View {
	@Binding var selectedCategory: String?
	@Environment(\.dismiss) var dismiss
	var body: some View {
	
		guard let category = selectedCategory else {
			return AnyView(Text("กรุณาเลือกประเภทก่อน").font(.largeTitle))
		}
		
		return AnyView(
			ZStack {
				Image("background02")
					.resizable()
					.scaledToFill()
					.opacity(0.8)
					.ignoresSafeArea()
				
				VStack(spacing: 24) {
					Spacer().frame(height: 70)
					// Flashcard Button
					NavigationLink(destination: category == "Fruit" ? AnyView(FruitsView()) : AnyView(AnimalsView())) {
						createButton(imageName: "flashcardButton")
					}
					
					// Scan Button
					NavigationLink(destination: category == "Fruit" ? AnyView(CameraFruitsView()) : AnyView(CameraAnimalsView())) {
						createButton(imageName: "scanButton")
					}
					
					// Quiz Button
					NavigationLink(destination: category == "Fruit" ?
								   AnyView(FruitQuizView(gameManagerVM: GameManagerVM(category: .fruits))) :
									AnyView(AnimalQuizView(gameManagerVM: GameManagerVM(category: .animals)))) {
						createButton(imageName: "quizButton")
					}
					
					Spacer()
				}
			}
				.navigationBarBackButtonHidden(true)
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button(action: {
							dismiss()
						}) {
							Image("backIcon")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 50, height: 50)
								.padding(8)
						}
					}
				}
			
		)
	}
	
	func createButton(imageName: String) -> some View {
		VStack {
			Image(imageName)
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
	}
}
