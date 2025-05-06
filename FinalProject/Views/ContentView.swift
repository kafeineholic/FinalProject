import SwiftUI

struct ContentView: View {
    @ObservedObject var gameManagerVM: GameManagerVM
    var body: some View {
        ZStack {
            Image("image")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .ignoresSafeArea()
            
            LinearGradient(colors: [.purple.opacity(0.4), .blue.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            if (gameManagerVM.model.quizCompleted) {
                QuizCompletedView(gameManagerVM: gameManagerVM)
            } else {
                VStack {
                    ReusableText(text: "Animal Knowledge Quiz!", size: 30)
                        .padding()
                    ReusableText(text: "Q:\(gameManagerVM.model.currentQuestionIndex + 1)/10", size: 25)

                    ReusableText(text: "Scores:\(gameManagerVM.score.description)", size: 18)
                    
                    Spacer()
                    
                                    
                    Image(gameManagerVM.model.quizModel.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                    
                    
            

                    Spacer()
                    
                    OptionsGridView(gameManagerVM: gameManagerVM)
                }
            }
        }
    }
}



