//
//  FruitsData.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 4/5/2568 BE.
//


import Foundation

// โครงสร้างข้อมูลของผลไม้ (ปรับให้ตรงกับ plist)
struct FruitItem: Identifiable, Decodable {
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
		// ใช้ชื่อผลไม้เป็นชื่อไฟล์ภาพ
		imageName = en.lowercased()
			.replacingOccurrences(of: " ", with: "")
			.components(separatedBy: CharacterSet.alphanumerics.inverted)
			.joined()
	}
}


struct FruitsData {
	// ฟังก์ชันสำหรับโหลดข้อมูลจาก FruitsData.plist
	static func loadTranslations() -> [String: FruitItem]? {
		guard let url = Bundle.main.url(forResource: "FruitsData", withExtension: "plist"),
			  let data = try? Data(contentsOf: url) else {
			print("ไม่พบไฟล์ FruitsData.plist")
			return nil
		}
		
		do {
			let decoder = PropertyListDecoder()
			let translations = try decoder.decode([String: FruitItem].self, from: data)
			return translations
		} catch {
			print("ข้อผิดพลาดในการ decode ข้อมูลจาก plist:")
			print("Error: \(error)")
			print("Localized: \(error.localizedDescription)")
			return nil
		}
	}
	
	// ฟังก์ชันเสริมสำหรับแปลงเป็น Array (ถ้าต้องการ)
	static func loadAsArray() -> [FruitItem]? {
		guard let dict = loadTranslations() else { return nil }
		return Array(dict.values)
	}
}
