import SwiftUI

struct CategorySelectionView: View {
	@Environment(\.dismiss) var dismiss
	@Binding var selectedCategory: String?
	@State private var isActive = false
	@State private var navigateToMenu = false
	
	var body: some View {
		NavigationStack {
			ZStack {
				Image("background02")
					.resizable()
					.scaledToFill()
					.opacity(0.8)
					.ignoresSafeArea()
				
				VStack(spacing: 24) {
					Spacer().frame(height: 70)
					
					// ปุ่ม Fruit
					Button(action: {
						selectedCategory = "Fruit"
						navigateToMenu = true
					}) {
						CategoryButton(imageName: "button02")
					}
					
					// ปุ่ม Animal
					Button(action: {
						selectedCategory = "Animal"
						navigateToMenu = true
					}) {
						CategoryButton(imageName: "button03")
					}
					
					Spacer()
				}
				.padding(.horizontal)
				
				// NavigationLink สำหรับนำทางไปยังหน้าเมนู
				NavigationLink(
					destination: MenuSelectionView(selectedCategory: $selectedCategory)
						.navigationBarBackButtonHidden(true),
					isActive: $navigateToMenu,
					label: { EmptyView() }
				)
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
}

struct CategoryButton: View {
	let imageName: String
	
	var body: some View {
		Image(imageName)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(width: 220, height: 80)
			.padding()
			.background(
				RoundedRectangle(cornerRadius: 40)
					.fill(Color(red: 255/255, green: 248/255, blue: 231/255)) // ใช้สีครีมอ่อน
					.shadow(color: Color.gray.opacity(0.2), radius: 6, x: 0, y: 4) // เงานุ่มๆ
			)
			.overlay(
				RoundedRectangle(cornerRadius: 40)
					.stroke(Color.gray.opacity(0.5), lineWidth: 2))
	}
}
