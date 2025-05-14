import AVFoundation
import UIKit

class SpeechManager: NSObject, AVSpeechSynthesizerDelegate {
    static let shared = SpeechManager()
    private let synthesizer = AVSpeechSynthesizer()
    private var speechCompletionHandler: (() -> Void)?
    private var didSpeak = false

    private override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(text: String, language: String, onSilentDetected: @escaping () -> Void) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = 0.5

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure audio session:", error)
        }

        didSpeak = false
        speechCompletionHandler = {
            if !self.didSpeak {
                onSilentDetected()
            }
        }

        synthesizer.speak(utterance)
    }


    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        didSpeak = true
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.speechCompletionHandler?()
        }
    }
}
