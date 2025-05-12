//
//  CameraFruitsModel.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 4/5/2568 BE.
//

import UIKit
import AVFoundation

class CameraFruitsModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
	private let session = AVCaptureSession()
	private let output = AVCapturePhotoOutput()
	private let queue = DispatchQueue(label: "camera.queue")
	
	@Published var previewLayer: AVCaptureVideoPreviewLayer?
	
	override init() {
		super.init()
		setup()
	}
	
	private func setup() {
		guard let device = AVCaptureDevice.default(for: .video),
			  let input = try? AVCaptureDeviceInput(device: device) else { return }
		
		if session.canAddInput(input) {
			session.addInput(input)
		}
		
		if session.canAddOutput(output) {
			session.addOutput(output)
		}
		
		previewLayer = AVCaptureVideoPreviewLayer(session: session)
		//previewLayer?.videoGravity = .resizeAspect
        previewLayer?.videoGravity = .resizeAspectFill

	}
	
	func startSession() {
		queue.async {
			self.session.startRunning()
		}
	}
	
	private var photoCallback: ((UIImage) -> Void)? = nil
	func takePhoto(completion: @escaping (UIImage) -> Void) {
		let settings = AVCapturePhotoSettings()
		self.photoCallback = completion
		output.capturePhoto(with: settings, delegate: self)
	}
	func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
		guard let data = photo.fileDataRepresentation(),
			  let image = UIImage(data: data) else { return }
		
		DispatchQueue.main.async {
			self.photoCallback?(image)
		}
	}
}
