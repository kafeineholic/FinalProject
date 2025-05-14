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
						Image("button05")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 180, height: 60)
							.padding()
							.background(
								RoundedRectangle(cornerRadius: 40)
									.fill(Color.white)
									.shadow(color: Color.gray.opacity(0.2), radius: 6, x: 0, y: 4)
							)
							.overlay(
								RoundedRectangle(cornerRadius: 40)
									.stroke(Color.gray.opacity(0.5), lineWidth: 2))
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

