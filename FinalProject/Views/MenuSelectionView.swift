//
//  GamesView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct MenuSelectionView: View {
	@Binding var selectedCategory: String?
	@Environment(\.dismiss) var dismiss
	var body: some View {
		// ตรวจสอบให้แน่ใจว่ามี category ที่เลือก
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
				
				VStack(spacing: 20) {
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
	
	// ฟังก์ชันสร้างปุ่มให้สวยงาม
	func createButton(imageName: String) -> some View {
		VStack {
			Image(imageName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 220, height: 80)
		}
	}
}
