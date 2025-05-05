//
//  FruitDataLoader.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 5/5/2568 BE.
//

import Foundation

struct FruitDataLoader {
	static func loadFruits() -> [FruitsData] {
		guard let url = Bundle.main.url(forResource: "FruitsData", withExtension: "plist") else {
			print("❌ ไม่พบไฟล์ FruitsData.plist")
			return []
		}
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = PropertyListDecoder()
			return try decoder.decode([FruitsData].self, from: data)
		} catch {
			print("❌ ข้อผิดพลาดในการโหลดข้อมูล: \(error)")
			return []
		}
	}
}
