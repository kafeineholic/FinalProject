import SwiftUI

struct ContentView: View {
	@State private var showSecondView = false
	
	var body: some View {
		
		NavigationStack {
			ZStack { //open zstack1
				// wallpaper (Hex: #FFF8E7)
				Color(red: 255/255, green: 248/255, blue: 231/255)
					.ignoresSafeArea()
				VStack { //open vstack1
					Button(action: {
						self.showSecondView.toggle()
					}) {
						Image(systemName: "play.circle.fill")
							.font(.system(size: 70))
							.foregroundStyle(.pink)
							.padding(.trailing)
					} //end button play
					.navigationDestination(isPresented: $showSecondView){
						SecondView()
					}
				} //end vstack1
			} //end zstack1
		} //end navstack
	}
}

#Preview {
	ContentView()
}
