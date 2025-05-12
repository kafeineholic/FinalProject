import Foundation
import SwiftUI
import AVFoundation


enum QuizCategory {
    case animals
    case fruits
}

class GameManagerVM: ObservableObject {
    @Published var model: Quiz
    @Published var score = 0
    @Published var category: QuizCategory
    
    private var questionPool: [QuizModel]
    private var currentIndex = 0
    private var audioPlayer: AVAudioPlayer?


    init(category: QuizCategory) {
        self.category = category
        self.questionPool = GameManagerVM.quizData(for: category).shuffled().prefix(10).map { $0 }
        self.model = GameManagerVM.createGameModel(i: 0, questionPool: self.questionPool)
    }

    static func createGameModel(i: Int, questionPool: [QuizModel]) -> Quiz {
        let quizModel = questionPool[i]
        let originalOptions = quizModel.optionsList
        let shuffledOptionsText = originalOptions.map { $0.option }.shuffled()

        let reassignedOptions = zip(originalOptions, shuffledOptionsText).map { (original, newText) in
            QuizOption(id: original.id, optionId: original.optionId, option: newText)
        }

        return Quiz(
            currentQuestionIndex: i,
            quizModel: QuizModel(
                imageName: quizModel.imageName,
                answerId: getShuffledAnswer(originalOptions: originalOptions,
                                            shuffledOptions: reassignedOptions,
                                            correctAnswerId: quizModel.answerId),
                optionsList: reassignedOptions
            )
        )
    }

    static func getShuffledAnswer(originalOptions: [QuizOption], shuffledOptions: [QuizOption], correctAnswerId: Int) -> Int {
        if let correctOriginalOption = originalOptions.first(where: { $0.id == correctAnswerId }),
           let index = shuffledOptions.firstIndex(where: { $0.option == correctOriginalOption.option }) {
            return shuffledOptions[index].id
        }
        return correctAnswerId // fallback
    }
    
    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else {
            print("❌ Sound file \(name).wav not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("❌ Could not play sound \(name): \(error.localizedDescription)")
        }
    }


    func verifyAnswer(selectedOption: QuizOption) {
        for index in model.quizModel.optionsList.indices {
            model.quizModel.optionsList[index].isMatched = false
            model.quizModel.optionsList[index].isSelected = false
        }

        if let index = model.quizModel.optionsList.firstIndex(where: { $0.optionId == selectedOption.optionId }) {
            model.quizModel.optionsList[index].isSelected = true

            if selectedOption.id == model.quizModel.answerId {
                model.quizModel.optionsList[index].isMatched = true
                score += 1
                playSound(named: "correct")
            } else {
                playSound(named: "wrong")
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if self.currentIndex < self.questionPool.count - 1 {
                    self.currentIndex += 1
                    self.model = GameManagerVM.createGameModel(i: self.currentIndex, questionPool: self.questionPool)
                } else {
                    self.model.quizCompleted = true
                    self.model.quizWinningStatus = true
                }
            }
        }
    }


    func restartGame() {
        self.currentIndex = 0
        self.score = 0
        self.questionPool = GameManagerVM.quizData(for: category).shuffled().prefix(10).map { $0 }
        self.model = GameManagerVM.createGameModel(i: 0, questionPool: self.questionPool)
    }

    func colorForOptionId(_ id: String) -> Color {
        switch id {
            case "A": return .yellow
            case "B": return .red
            case "C": return .green
            case "D": return .purple
            default: return .gray
        }
    }
}

extension GameManagerVM {
    static func quizData(for category: QuizCategory) -> [QuizModel] {
        let filename: String
        switch category {
            case .animals: filename = "quizA"
            case .fruits: filename = "quizB"
        }

        guard let url = Bundle.main.url(forResource: filename, withExtension: "plist") else {
            print("❌ Failed to locate \(filename).plist")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            return try decoder.decode([QuizModel].self, from: data)
        } catch {
            print("❌ Error decoding \(filename).plist: \(error)")
            return []
        }
    }
}

