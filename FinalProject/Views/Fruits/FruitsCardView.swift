//
//  FruitsCardView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 5/5/2568 BE.
//

import SwiftUI

struct FruitsCardView: View {
	let fruit: FruitsData
	
	var body: some View {
		VStack(spacing: 12) {
			Text(fruit.english)
				.font(.title.bold())
			Divider()
			Text("Thai: \(fruit.thai)")
			Text("Japanese: \(fruit.japanese)")
		}
		.padding()
		.frame(width: 300, height: 200)
		.background(Color.white)
		.cornerRadius(12)
		.shadow(radius: 5)
	}
}
