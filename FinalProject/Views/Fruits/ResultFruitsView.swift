//
//  ResultFruitsView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 4/5/2568 BE.
//

import SwiftUI

struct ResultFruitsView: View {
	
	var photo: UIImage
	@State private var translations: [String: String] = [:]
	let allTranslations = FruitsData.loadTranslations()
	
	var body: some View {
		ScrollView {
			VStack(spacing: 24) {
				// pic
				Image(uiImage: photo)
					.resizable()
					.scaledToFit()
					.frame(maxWidth: .infinity)
					.frame(height: UIScreen.main.bounds.width * 0.95) // pic frame
					.cornerRadius(16)
					.padding(.top, 70) // pic down
					.padding([.leading, .trailing, .bottom])
				
				// row
				VStack(alignment: .leading, spacing: 16) {
					TranslationRow(label: "TH", value: translations["th"] ?? "-")
					TranslationRow(label: "EN", value: translations["en"] ?? "-")
					TranslationRow(label: "JP", value: translations["jp"] ?? "-")
				}
				.padding()
				.background(Color(.secondarySystemBackground))
				.cornerRadius(16)
				.frame(maxWidth: 320) //
				.padding([.horizontal])
				.padding(.top, 20) // row down
				.shadow(radius: 5)
				
				Spacer()
			}
			.padding(.top)
		}
		.background(Color(.systemBackground))
		.onAppear {
			classifyAndTranslate()
		}
	}
	
	func classifyAndTranslate() {
		let model = FruitsMLModel(myUIImage: photo)
		let result = model.classifyingFruitImage()
		let fruit = result.components(separatedBy: "\n")[0].lowercased()

		if let allTranslations = FruitsData.loadTranslations(),
		   let fruitTranslation = allTranslations[fruit] {
			translations = [
				"th": fruitTranslation.thai,
				"en": fruitTranslation.english,
				"jp": fruitTranslation.japanese
			]
		} else {
			translations = ["th": "ไม่ทราบ", "en": fruit, "jp": "不明"]
		}
	}

}


struct TranslationRow: View {
	let label: String
	let value: String
	@State private var showSilentAlert = false
	@State private var isSpeaking = false

	var body: some View {
		HStack {
			Text("Name \(label):")
				.fontWeight(.semibold)
			Text(value)
				.foregroundColor(.primary)
			Spacer()
			
			Button(action: {
				speak()
			}) {
				Image(systemName: "speaker.wave.2.fill")
					.foregroundColor(.white)
					.padding(10)
					.background(
						Circle()
							.fill(isSpeaking ? Color.blue.opacity(0.6) : Color(.systemGray5))
					)
			}
			.animation(.easeInOut(duration: 0.2), value: isSpeaking)
		}
		
		.font(.system(size: 16))
		.padding(.vertical, 7)
		.alert(isPresented: $showSilentAlert) {
			Alert(
				title: Text("Silent Mode!"),
				message: Text(" Turn on Volume"),
				dismissButton: .default(Text("OK"))
			)
		}
	}

	func speak() {
		let langCode: String
		switch label.uppercased() {
		case "TH":
			langCode = "th-TH"
		case "EN":
			langCode = "en-US"
		case "JP", "JA":
			langCode = "ja-JP"
		default:
			langCode = "en-US"
		}

		isSpeaking = true

		SpeechManager.shared.speak(text: value, language: langCode) {
			showSilentAlert = true
		}

		// Stop the highlight after delay
		DispatchQueue.main.asyncAfter(deadline: .now() + Double(value.count) * 0.1 + 0.5) {
			isSpeaking = false
		}
	}
}

//#Preview {
//    ResultFruitsView()
//}
//example
#Preview {
	let sampleImage = UIImage(named: "apple")!
		return ResultFruitsView(photo: sampleImage)
  }
