//
//  AnimalsCardView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 7/5/2568 BE.
//

import Foundation

import SwiftUI

struct AnimalsCardView: View {
	
	@State var frontDegree = 0.0
	@State var backDegree = -90.0
	@State var isFlipping = false
	
	let width: CGFloat = 300
	let height: CGFloat = 450
	let durationAndDelay: CGFloat = 0.2
	
	let animal: AnimalItem
	
	func flipCard() {
		isFlipping.toggle()
		if isFlipping {
			withAnimation(.linear(duration: durationAndDelay)) {
				frontDegree = 90
			}
			withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
				backDegree = 0
			}
		} else {
			withAnimation(.linear(duration: durationAndDelay)) {
				backDegree = -90
			}
			withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
				frontDegree = 0
			}
		}
	}
	var body: some View {
		ZStack {
			AnimalsCardBack(width: width, height: height, degree: $backDegree, animal: animal)
			AnimalsCardFront(width: width, height: height, degree: $frontDegree, animal: animal)
		}
		.onTapGesture {
			flipCard()
		}
	}
}

struct AnimalsCardFront: View {
	let width: CGFloat
	let height: CGFloat
	@Binding var degree: Double
	
	let animal: AnimalItem
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20)
				.fill(Color.white)
				.frame(width: width, height: height)
				.shadow(color: .gray, radius: 5, x: 0, y: 0)
			Image(animal.imageName)
				.resizable()
				.scaledToFit()
				.frame(width: width * 0.9, height: height * 0.85)
		} //end ZStack
		.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
	}
}

struct AnimalsCardBack: View {
	let width: CGFloat
	let height: CGFloat
	@Binding var degree: Double
	
	let animal: AnimalItem
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20)
				.fill(Color.white)
				.frame(width: width, height: height)
				.shadow(color: .gray, radius: 5, x: 0, y: 0)
			
			VStack(spacing: 12) {
				Text(animal.en)
					.font(.system(size: 24, weight: .bold))
					.foregroundColor(Color.pink)
				
				Text(animal.th)
					.font(.system(size: 18, weight: .medium))
					.foregroundColor(Color.purple)
				
				Text(animal.jp)
					.font(.system(size: 16, weight: .light))
					.foregroundColor(Color.blue)
			} //end VStack
			.padding()
		} //end ZStack
		.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
	}
}
