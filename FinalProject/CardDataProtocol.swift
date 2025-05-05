//
//  CardDataProtocol.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 5/5/2568 BE.
//

import SwiftUI

// Protocol หลักสำหรับข้อมูลการ์ดทุกชนิด
protocol CardData: Identifiable {
	var id: UUID { get }
	var english: String { get }
	var thai: String { get }
	var japanese: String { get }
}

// Extension เพื่อให้มี ID อัตโนมัติถ้าโมเดลไม่มี
extension CardData {
	var id: UUID { UUID() }
}
