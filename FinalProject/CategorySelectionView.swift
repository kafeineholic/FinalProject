//
//  SecondView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct CategorySelectionView: View {
	@Environment(\.dismiss) var dismiss

	var body: some View {
		NavigationStack {
			ZStack {
				Image("background02")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
				VStack(spacing: 24) {
					Spacer().frame(height: 30)

					CategoryButton(imageName: "button02", destination: FruitsView())
					CategoryButton(imageName: "button03", destination: AnimalsView())

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
}

struct CategoryButton<Destination: View>: View {
	let imageName: String
	let destination: Destination

	var body: some View {
		NavigationLink(destination: destination) {
			ZStack {
				// พื้นหลังครีม ขนาดกำลังดี
				RoundedRectangle(cornerRadius: 25)
					.fill(Color(red: 255/255, green: 248/255, blue: 231/255)) // สีครีม #FFF8E7
					.frame(width: 280, height: 120)
					.shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

				
				Image(imageName)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 220, height: 80)
					.saturation(0.95)
			}
			.padding(.vertical, 10) // ระยะห่างระหว่างปุ่ม
		}
	}
}


#Preview {
	CategorySelectionView()
}
