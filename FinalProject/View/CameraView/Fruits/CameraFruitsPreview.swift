//
//  CameraFruitsPreview.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 4/5/2568 BE.
//

import SwiftUI
import AVFoundation

struct CameraFruitsPreview: UIViewRepresentable {
	let cameraModel: CameraFruitsModel

	func makeUIView(context: Context) -> UIView {
		let view = UIView(frame: UIScreen.main.bounds)
		if let previewLayer = cameraModel.previewLayer {
			previewLayer.frame = view.bounds
			view.layer.addSublayer(previewLayer)
		}
		return view
	}

	func updateUIView(_ uiView: UIView, context: Context) {}
}
