
import SwiftUI

struct CameraAnimalsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var cameraModel = CameraAnimalsModel()
    @State private var myImage: UIImage? = nil
    @State private var showMyImage: Bool = false
    @State private var navigateToResult = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // กล้องชิดบนสุดและสูง 600
                CameraAnimalsPreview(cameraModel: cameraModel)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 600)

                VStack(spacing: 0) {
                    Spacer().frame(height: 600) // ดัน UI ลงมาใต้กล้อง

                

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
                    ResultAnimalsView(photo: image)
                        .onDisappear {
                            myImage = nil
                            showMyImage = false
                            navigateToResult = false
                        }
                } else {
                    Text("No image available")
                }
            } //end navdestination
            Spacer()
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "house.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.white, .blue)
                                .padding()
                        }
                    }
                }  //end toolbar
        } //end navstack
    }
}

#Preview {
    CameraAnimalsView()
}
