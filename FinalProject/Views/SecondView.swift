//
//  SecondView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct SecondView: View {
	
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
		ZStack {
			Color(red: 0.4, green: 0.84, blue: 0.93)
				.ignoresSafeArea()
			VStack(spacing: 20) {
				NavigationLink(destination: FruitsView()) {
					ZStack {
						Image("wallpaper")
							.resizable()
							.scaledToFill()
							.frame(height: 230)
							.clipShape(RoundedRectangle(cornerRadius: 25))
							.shadow(
								color: .black.opacity(0.3),
								radius: 10,
								x: 0,
								y: 5
							)
							.shadow(
								color: .black.opacity(0.1),
								radius: 1,
								x: 0,
								y: 1
							)
						
						Text("Fruits & Veggies")
							.font(.system(size: 28, weight: .bold))
							.foregroundColor(.white)
							.shadow(radius: 3)
					}
					.padding(.horizontal)
				}
				
				NavigationLink(destination: AnimalsView()) {
					ZStack {
						Image("wallpaper") 
							.resizable()
							.scaledToFill()
							.frame(height: 230)
							.clipShape(RoundedRectangle(cornerRadius: 25))
							.shadow(
								color: .black.opacity(0.3),
								radius: 10,
								x: 0,
								y: 5
							)
							.shadow(
								color: .black.opacity(0.1),
								radius: 1,
								x: 0,
								y: 1
							)
						
						Text("Animals")
							.font(.system(size: 28, weight: .bold))
							.foregroundColor(.white)
							.shadow(radius: 3)
					}
					.padding(.horizontal)
				}
				
				NavigationLink(destination: GamesView()) {
					ZStack {
						Image("wallpaper")  // เปลี่ยนเป็นชื่อรูปของคุณ
							.resizable()
							.scaledToFill()
							.frame(height: 230)
							.clipShape(RoundedRectangle(cornerRadius: 25))
							.shadow(
								color: .black.opacity(0.3),
								radius: 10,
								x: 0,
								y: 5
							)
							.shadow(
								color: .black.opacity(0.1),
								radius: 1,
								x: 0,
								y: 1
							)
						
						Text("GAMES")
							.font(.system(size: 28, weight: .bold))
							.foregroundColor(.white)
							.shadow(radius: 3)
					}
					.padding(.horizontal)
				}
			} //end vstack
			.padding(.top,20)
			Spacer()
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
				}  //end toolbar
		}//end zstack
	}  //end navstack
}

#Preview {
	SecondView()
}
