//
//  MainView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct MainView: View {
	var body: some View {
		NavigationStack{
			ZStack { //open zstack1
				// wallpaper (Hex: #FFF8E7)
				Color(red: 255/255, green: 248/255, blue: 231/255)
					.ignoresSafeArea()
				VStack { //open vstack1
					NavigationLink(destination: SecondView()){
						Image(systemName: "play.circle.fill")
							.font(.system(size: 70))
							.foregroundStyle(.pink)
							.padding(.trailing)
					}
				} //end vstack1
			} //end zstack1
		} //end navView
	}
}

#Preview {
	MainView()
}
