//
//  CameraFruitsView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct CameraFruitsView: View {
	
	@Environment(\.dismiss) var dismiss
	
	@StateObject private var cameraModel = CameraFruitsModel()
	@State private var myImage: UIImage? = nil
	@State private var showMyImage: Bool = false
	@State private var navigateToResult = false
	
    var body: some View {
		NavigationStack {
			ZStack(alignment: .top) {
				// กล้องชิดบนสุดและสูง 600
				CameraFruitsPreview(cameraModel: cameraModel)
					//.ignoresSafeArea(edges: .top)
					//.frame(height: 600)
                    .ignoresSafeArea()

				VStack(spacing: 0) {
					Spacer().frame(height: 600) //UI
					// ปุ่มถ่ายรูป
					Button(action: {
						cameraModel.takePhoto { image in
							self.myImage = image
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
								self.showMyImage = true
							}
						}
					}) {
						Text("📸 Take a Photo")
							.font(.title2)
							.bold()
							.padding()
							.frame(maxWidth: .infinity)
							.background(Color.green)
							.foregroundColor(.white)
							.cornerRadius(12)
							.padding(.horizontal, 40)
					}
					.padding(.top, 40)

					Spacer()
				}
			} //end zstack1
			.background(Color(.systemGroupedBackground))
			.onAppear {
				cameraModel.startSession()
			}
			.onChange(of: showMyImage) {
				if showMyImage {
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
						navigateToResult = true
					}
				}
			}
			.navigationDestination(isPresented: $navigateToResult) {
				if let image = myImage {
					ResultFruitsView(photo: image)
						.onDisappear {
							myImage = nil
							showMyImage = false
							navigateToResult = false
						}
				} else {
					Text("No image available")
				}
			} //end navdestination
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: {
						dismiss()
					}) {
						Image("homeIcon")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 50, height: 50)
							.padding(8)
					}
				}
			}  //end toolbar
		} //end navstack
    }
}

#Preview {
    CameraFruitsView()
}
