//
//  FruitsCardView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 5/5/2568 BE.
//

import SwiftUI

struct FruitsCardView: View {
	let fruit: FruitItem
	
	var body: some View {
		VStack {
			Text(fruit.en)
				.font(.largeTitle)
			Text(fruit.th)
				.font(.title2)
			Text(fruit.jp)
				.font(.title3)
		}
		.padding()
		.frame(width: 300, height: 200)
		.background(Color.white)
		.cornerRadius(12)
		.shadow(radius: 5)
	}
}
