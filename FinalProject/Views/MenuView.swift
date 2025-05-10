//
//  GamesView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct MenuView: View {
	
	@Environment(\.dismiss) var dismiss
	
	@State private var showCameraFruitsView = false
	@State private var showCameraAnimalsView = false
	
	var body: some View {
		NavigationStack {
			ZStack {
				Image("background02")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
				VStack(spacing: 24) {
					Spacer().frame(height: 30)

					CategoryButton(imageName: "button02g", destination: FruitsView())
					CategoryButton(imageName: "button02g", destination: AnimalsView())
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


#Preview {
	MenuView()
}
