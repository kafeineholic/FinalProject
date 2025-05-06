//
//  CategorySelectionView.swift
//  Quiz
//
//  Created by a. on 6/5/2568 BE.
//

import SwiftUI

struct CategorySelectionView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Select Quiz Category")
                    .font(.largeTitle)
                    .bold()
                
                NavigationLink(destination: ContentView(gameManagerVM: GameManagerVM(category: .animals))) {
                    Text("🐶 Animal Quiz")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: FruitQuizView(gameManagerVM: GameManagerVM(category: .fruits))) {
                    Text("🍎 Fruit Quiz")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}


