import Foundation
import SwiftUI

struct Quiz {
    var currentQuestionIndex: Int
    var quizModel: QuizModel
    var quizCompleted: Bool = false
    var quizWinningStatus: Bool = false
}

struct QuizModel: Codable {
    let imageName: String
    let answerId: Int
    var optionsList: [QuizOption]
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


struct QuizOption : Identifiable, Codable{
    var id: Int
    var optionId: String
    var option: String
    
    var isSelected : Bool = false
    var isMatched : Bool = false
    
    enum CodingKeys: String, CodingKey {
            case id, optionId, option // exclude isSelected, isMatched
        }
}

