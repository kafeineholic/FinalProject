import SwiftUI

struct ResultFruitsView: View {
	
	var photo: UIImage
	@State private var translations: [String: String] = [:]
	let allTranslations = FruitsData.loadTranslations()
	@Environment(\.dismiss) var dismiss
	var body: some View {
		ZStack {
			Image("background04")
				.resizable()
				.scaledToFill()
				.ignoresSafeArea()
				.ignoresSafeArea()
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
				.cornerRadius(16)
				.frame(maxWidth: 320) //
				.padding([.horizontal])
				.padding(.top, 20) // row down
				.shadow(radius: 5)
				
				Spacer()
			}
			.padding(.top)
		}
		.onAppear {
			classifyAndTranslate()
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
	
	func classifyAndTranslate() {
		let model = FruitsMLModel(myUIImage: photo)
		let result = model.classifyingFruitImage()
		let fruit = result.components(separatedBy: "\n")[0].lowercased()
		
		// ใช้ loadTranslations() เพื่อดึงข้อมูลแปลผล
		if let allTranslations = FruitsData.loadTranslations(),
		   let fruitTranslation = allTranslations[fruit] {
			translations = [
				"th": fruitTranslation.th,
				"en": fruitTranslation.en,
				"jp": fruitTranslation.jp
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
		Button(action: {
			speak()
		}) {
			HStack {
				Image(systemName: isSpeaking ? "pause.fill" : "play.fill")
					.foregroundColor(.red)
				
				Text("\(label) : \(value)")
					.font(.headline)
					.foregroundColor(.black)
				
				Spacer()
			}
			.padding()
			.frame(maxWidth: .infinity)
			.background(Color.white)
			.cornerRadius(25)
			.shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
		}
		.padding(.horizontal, 20)
		.alert(isPresented: $showSilentAlert) {
			Alert(
				title: Text("Silent Mode!"),
				message: Text("Turn on Volume"),
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
		
		DispatchQueue.main.asyncAfter(deadline: .now() + Double(value.count) * 0.1 + 0.5) {
			isSpeaking = false
		}
	}
}







//example
#Preview {
	let sampleImage = UIImage(named: "apple") ?? UIImage(systemName: "photo")!
	return ResultFruitsView(photo: sampleImage)
}

