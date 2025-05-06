//
//  ResultAnimalsView.swift
//  FinalProject
//
//  Created by Siripoom Jaruphoom on 6/5/25.
//

import SwiftUI

struct ResultAnimalsView: View {
        var photo: UIImage
        @State private var translations: [String: String] = [:]
        let allTranslations = AnimalsData.loadTranslations()
        
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
                    .cornerRadius(16)
                    .frame(maxWidth: 320) //
                    .padding([.horizontal])
                    .padding(.top, 20) // row down
                    .shadow(radius: 5)
                    
                    Spacer()
                }
                .padding(.top)
            }
            .background(Color(red: 0.88, green: 0.95, blue: 1.0))

            .onAppear {
                classifyAndTranslate()
            }
        }
        
        func classifyAndTranslate() {
            let model = AnimalsMLModel(myUIImage: photo)
            let result = model.classifyingAnimalImage()
            let animal = result.components(separatedBy: "\n")[0].lowercased()

            // ใช้ loadTranslations() เพื่อดึงข้อมูลแปลผล
            if let allTranslations = AnimalsData.loadTranslations(),
               let animalTranslation = allTranslations[animal] {
                translations = [
                    "th": animalTranslation.th,
                    "en": animalTranslation.en,
                    "jp": animalTranslation.jp
                ]
            } else {
                translations = ["th": "ไม่ทราบ", "en": "Unknown", "jp": "不明"]
            }
        }

    }




//example
#Preview {
    let sampleImage = UIImage(named: "jellyfish") ?? UIImage(systemName: "photo")!
    return ResultAnimalsView(photo: sampleImage)
}


