//
//  MainView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct MainView: View {
	
	@State private var isAnimating = false
	@State private var selectedCategory: String? = nil  // เก็บค่าประเภทที่เลือก
	
	var body: some View {
		NavigationStack{
			ZStack { //open zstack1
				Image("background01")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
					.ignoresSafeArea()
				VStack { //open vstack1
					NavigationLink(destination: CategorySelectionView(selectedCategory: $selectedCategory)) {
						Image("button01")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(maxWidth: 250)
							.scaleEffect(isAnimating ? 1.2 : 1.0)
							.animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isAnimating)
							.onAppear { isAnimating = true }
							.saturation(0.95)
					}
				} //end vstack1
			} //end zstack1
		} //end navView
	}
}

#Preview {
	MainView()
}
