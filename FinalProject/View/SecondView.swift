//
//  SecondView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct SecondView: View {
	
	@Environment(\.dismiss) var dismiss
	@State private var showFruitsView = false
	@State private var showAnimalsView = false
	
	@State private var showCameraView = false
	//ตัวแปรรับรูปภาพจาก CameraView
	@State private var myImage : UIImage = UIImage()
	//ตัวแปรควบคุมการแสดง myImage ที่ได้มาจาก CameraView
	@State private var showMyImage : Bool = false
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color(red: 0.4, green: 0.84, blue: 0.93)
					.ignoresSafeArea()
				VStack(spacing: 20) {
					// Fruits
					Button(action: {
						// action สำหรับปุ่มที่ 1
					}) {
						ZStack {
							Image("wallpaper") // เปลี่ยนเป็นชื่อรูปของคุณ
								.resizable()
								.scaledToFill()
								.frame(height: 230)
								.clipShape(RoundedRectangle(cornerRadius: 25))
								.shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
								.shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
							
							Text("Fruits & Veggies")
								.font(.system(size: 28, weight: .bold))
								.foregroundColor(.white)
								.shadow(radius: 3)
						}
						.padding(.horizontal)
					}
					
					//Animals
					Button(action: {
						// action สำหรับปุ่มที่ 2
					}) {
						ZStack {
							Image("wallpaper") // เปลี่ยนเป็นชื่อรูปของคุณ
								.resizable()
								.scaledToFill()
								.frame(height: 230)
								.clipShape(RoundedRectangle(cornerRadius: 25))
								.shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
								.shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
							
							Text("Fruits & Veggies")
								.font(.system(size: 28, weight: .bold))
								.foregroundColor(.white)
								.shadow(radius: 3)
						}
						.padding(.horizontal)
					}
					
					//Games
					Button(action: {
						self.showCameraView.toggle()
					}) {
						ZStack {
							Image("wallpaper") // เปลี่ยนเป็นชื่อรูปของคุณ
								.resizable()
								.scaledToFill()
								.frame(height: 230)
								.clipShape(RoundedRectangle(cornerRadius: 25))
								.shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
								.shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
							
							Text("Animals")
								.font(.system(size: 28, weight: .bold))
								.foregroundColor(.white)
								.shadow(radius: 3)
						}
						.padding(.horizontal)
						.navigationDestination(isPresented: $showCameraView){
							CameraView()
						}
					}
				} //end vstack
				.padding(.top, 20)
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
				} //end toolbar
			} //end zstack
		}//end navstack
	}
}



#Preview {
	SecondView()
}
