//
//  AnimalsData.swift
//  FinalProject
//
//  Created by Siripoom Jaruphoom on 6/5/25.
//

import Foundation

struct AnimalItem: Identifiable, Decodable {
    var id = UUID()
    let en: String
    let th: String
    let jp: String
    let imageName: String
    
    enum CodingKeys: String, CodingKey {
        case en, th, jp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        en = try container.decode(String.self, forKey: .en)
        th = try container.decode(String.self, forKey: .th)
        jp = try container.decode(String.self, forKey: .jp)
        // ใช้ชื่อสัตว์เป็นชื่อไฟล์ภาพ
        imageName = en.lowercased()
            .replacingOccurrences(of: " ", with: "")
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
    }
}


struct AnimalsData {
    // ฟังก์ชันสำหรับโหลดข้อมูลจาก AnimalsData.plist
    static func loadTranslations() -> [String: AnimalItem]? {
        guard let url = Bundle.main.url(forResource: "AnimalsData", withExtension: "plist"),
              let data = try? Data(contentsOf: url) else {
            print("ไม่พบไฟล์ Animals.plist")
            return nil
        }
        
        do {
            let decoder = PropertyListDecoder()
            let translations = try decoder.decode([String: AnimalItem].self, from: data)
            return translations
        } catch {
            print("ข้อผิดพลาดในการ decode ข้อมูลจาก plist:")
            print("Error: \(error)")
            print("Localized: \(error.localizedDescription)")
            return nil
        }
    }
    
    // ฟังก์ชันเสริมสำหรับแปลงเป็น Array (ถ้าต้องการ)
    static func loadAsArray() -> [AnimalItem]? {
        guard let dict = loadTranslations() else { return nil }
        return Array(dict.values)
    }
}
