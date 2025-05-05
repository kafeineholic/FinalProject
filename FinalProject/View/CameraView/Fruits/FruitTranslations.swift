//
//  FruitTranslations.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 4/5/2568 BE.
//

import SwiftUI

struct FruitTranslations {
	static func loadTranslations() -> [String: [String: String]] {
		guard let url = Bundle.main.url(forResource: "FruitTranslations", withExtension: "plist"),
			  let data = try? Data(contentsOf: url),
			  let plist = try? PropertyListSerialization.propertyList(from: data, format: nil),
			  let dict = plist as? [String: [String: String]] else {
			return [:]
		}
		return dict
	}
}


