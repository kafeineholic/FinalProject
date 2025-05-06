import SwiftUI

struct QuizCompletedView: View {
    var gameManagerVM: GameManagerVM

    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "gamecontroller.fill")
                .foregroundColor(.yellow)
                .font(.system(size: 70))
                .shadow(radius: 10)
                .padding()

            // 🎉 Title
            Text(titleText())
                .font(.system(size: 36, weight: .heavy, design: .rounded))
                .foregroundColor(.orange)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 2, y: 2)
                .multilineTextAlignment(.center)

            // 🎈 Message
            Text(scoreMessage())
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 1)
                .padding(.horizontal)

            // 🎯 Score Display
            Text("Your Score: \(gameManagerVM.score)/10")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 1, y: 2)

            // 🌟 Stars if Perfect
            if gameManagerVM.score == 10 {
                HStack(spacing: 12) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 32))
                            .shadow(radius: 3)
                    }
                }
            }

            // 🔄 Play Again Button
            Button(action: {
                gameManagerVM.restartGame()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 28))

                    Text("Play Again")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                }
                .frame(width: 280, height: 60)
                .background(Color.purple.opacity(0.9))
                .cornerRadius(35)
                .shadow(radius: 5)
            }
        }
        .padding()
        
    }

    // MARK: - Helper Texts

    func titleText() -> String {
        switch gameManagerVM.score {
        case 10: return "🌟 AMAZING! 🌟"
        case 8...9: return "👏 So Close!"
        case 5...7: return "💪 Great Try!"
        default: return "🚀 Keep Practicing!"
        }
    }

    func scoreMessage() -> String {
        switch gameManagerVM.score {
        case 10: return "You're an animal expert! 🐾"
        case 8...9: return "You almost nailed it! Keep going! 🎉"
        case 5...7: return "You're learning fast! Just a little more! 🧠"
        default: return "Don't give up — next time you'll shine! 🌈"
        }
    }
}
