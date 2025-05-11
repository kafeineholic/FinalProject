//
//  SecondView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct CategorySelectionView: View {
	@Environment(\.dismiss) var dismiss
	@Binding var selectedCategory: String?
	@State private var isActive = false
	
	var body: some View {
		NavigationView {
					ZStack {
						Image("background02")
							.resizable()
							.scaledToFill()
							.ignoresSafeArea()
						
						VStack(spacing: 24) {
							Spacer().frame(height: 30)
							
							// ปุ่ม Fruit
							Button(action: {
								selectedCategory = "Fruit"
								isActive = true // เปิดการ navigate
							}) {
								CategoryButton(imageName: "button02")
							}
							.background(
								NavigationLink(
									destination: MenuSelectionView(selectedCategory: $selectedCategory),
									isActive: $isActive,
									label: { EmptyView() }
								)
							)
							
							// ปุ่ม Animal
							Button(action: {
								selectedCategory = "Animal"
								isActive = true // เปิดการ navigate
							}) {
								CategoryButton(imageName: "button03")
							}
							
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
	
	var body: some View {
		Image(imageName)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(width: 220, height: 80)
			.padding()
			.background(Color(red: 255/255, green: 248/255, blue: 231/255))
			.cornerRadius(25)
	}
}
