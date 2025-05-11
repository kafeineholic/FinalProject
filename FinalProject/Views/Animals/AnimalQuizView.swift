import SwiftUI

struct AnimalQuizView: View {
    @ObservedObject var gameManagerVM: GameManagerVM
	@Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Image("animalQuizBackground")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
				.opacity(0.7)
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
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					dismiss()
				}) {
					Image("homeIcon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 50, height: 50)
						.padding(8)
				}
			}
		}
    }
}



