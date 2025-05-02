//
//  CameraView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
	@Binding var myImage : UIImage
	@Binding var showMyImage : Bool
	func makeUIViewController(context: Context) ->
	UIImagePickerController {
		return UIImagePickerController()
	}
	func makeCoordinator() -> CameraView.CameraViewHelper {
		return CameraViewHelper(parent: self)
	}
	func updateUIViewController(_ myImagePickerController:
								UIImagePickerController, context: Context) {
		myImagePickerController.sourceType = .camera
		myImagePickerController.allowsEditing = true
		myImagePickerController.delegate = context.coordinator
	}
}
extension CameraView{
	class CameraViewHelper : NSObject, UINavigationControllerDelegate,
							 UIImagePickerControllerDelegate{
		var parent : CameraView
		init(parent: CameraView) {
			self.parent = parent
		}
		func imagePickerControllerDidCancel(_ picker:
											UIImagePickerController) {
			picker.dismiss(animated: true, completion: nil)
		}
		func imagePickerController(_ picker: UIImagePickerController,
								   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :
																			Any]) {
			//1. ปิด camera/album controller
			picker.dismiss(animated: true, completion: nil)
			//#2 อ่านค่ารูปที่ถ่ายเป็บไว้ในตัวแปร TheImage
			//ถ้า AllowEditing เป็น False
			//ใช้ UIImagePickerController.InfoKey.originalImage
			self.parent.myImage =
			info[UIImagePickerController.InfoKey.editedImage] as! UIImage
			self.parent.showMyImage = true
			//3.เขียนไฟล์รูปภาพลงไปใน CameraRoll
			UIImageWriteToSavedPhotosAlbum(self.parent.myImage, self,
										   nil, nil)
		}
	}
}

#Preview {
    CameraView()
}
