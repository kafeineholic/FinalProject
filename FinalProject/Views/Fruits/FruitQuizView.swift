//
//  FruitQuizView.swift
//  Quiz
//
//  Created by a. on 6/5/2568 BE.
//

import SwiftUI

struct FruitQuizView: View {
    @ObservedObject var gameManagerVM: GameManagerVM

    var body: some View {
        ZStack {
            LinearGradient(colors: [.green.opacity(0.3), .yellow.opacity(0.3)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()

            if gameManagerVM.model.quizCompleted {
                QuizCompletedView(gameManagerVM: gameManagerVM)
            } else {
                VStack {
                    ReusableText(text: "Fruit Knowledge Quiz!", size: 30)
                    ReusableText(text: "Q:\(gameManagerVM.model.currentQuestionIndex + 1)/10", size: 25)

                    ReusableText(text: "Score: \(gameManagerVM.score)", size: 18)

                    Spacer()

                    Image(gameManagerVM.model.quizModel.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)

                    Spacer()

                    OptionsGridView(gameManagerVM: gameManagerVM)
                }
                .padding()
            }
        }
    }
}
