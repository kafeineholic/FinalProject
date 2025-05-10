//
//  SecondView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct CategorySelectionView: View {
	@Environment(\.dismiss) var dismiss
	@Binding var selectedCategory: String?  // ใช้ @Binding เพื่อรับค่าจาก MainView

	var body: some View {
		NavigationStack {
			ZStack {
				Image("background02")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
				VStack(spacing: 24) {
					Spacer().frame(height: 30)

					// ปุ่มเลือกประเภท Fruit
					CategoryButton(imageName: "button02", category: "Fruit", selectedCategory: $selectedCategory)
					
					// ปุ่มเลือกประเภท Animal
					CategoryButton(imageName: "button03", category: "Animal", selectedCategory: $selectedCategory)

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

struct CategoryButton: View {
	let imageName: String
	let category: String  // เก็บประเภทที่เลือก
	@Binding var selectedCategory: String?

	var body: some View {
		NavigationLink(destination: MenuSelectionView(selectedCategory: $selectedCategory)) {
			ZStack {
				// พื้นหลังครีม ขนาดกำลังดี
				RoundedRectangle(cornerRadius: 25)
					.fill(Color(red: 255/255, green: 248/255, blue: 231/255)) // สีครีม
					.frame(width: 280, height: 120)
					.shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

				Image(imageName)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 220, height: 80)
					.saturation(0.95)
			}
			.padding(.vertical, 10)
		}
		.onTapGesture {
			selectedCategory = category  // ตั้งค่าประเภทเมื่อเลือกปุ่ม
		}
	}
}
