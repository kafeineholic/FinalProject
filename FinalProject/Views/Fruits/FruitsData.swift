//
//  FruitsData.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 4/5/2568 BE.
//


import Foundation

// โครงสร้างข้อมูลของผลไม้ (ปรับให้ตรงกับ plist)
struct FruitItem: Codable, Identifiable {
	var id = UUID()  // สำหรับการใช้งานกับ ForEach
	let en: String
	let th: String
	let jp: String
	// กำหนด CodingKeys เพื่อให้ตรงกับ key ใน plist
	enum CodingKeys: String, CodingKey {
		case en, th, jp
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
