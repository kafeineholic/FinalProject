//
//  FruitTranslations.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 4/5/2568 BE.
//

// โครงสร้างข้อมูลที่ตรงกับ Keys ใน plist
import Foundation

struct FruitsData: Codable, Identifiable {
	var id = UUID()  // สำหรับการใช้งานกับ ForEach
	let english: String
	let thai: String
	let japanese: String

	enum CodingKeys: String, CodingKey {
		case english
		case thai
		case japanese
	}

	static func loadTranslations() -> [String: FruitsData]? {
		// โหลดข้อมูลจาก FruitsData.plist
		guard let url = Bundle.main.url(forResource: "FruitsData", withExtension: "plist"),
			  let data = try? Data(contentsOf: url),
			  let decoder = try? PropertyListDecoder().decode([String: FruitsData].self, from: data) else {
			return nil
		}
		return decoder
	}
}
