//
//  DraftRestart.swift
//  FinalProject
//
//  Created by a. on 12/5/2568 BE.
//

import SwiftUI

struct DraftRestart: View {
    var body: some View {
        ZStack {
            Image("background03")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Restart!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                Button(action: {
                    print("Restart tapped")
                   
                }) {  Image(systemName: "gobackward")
                        .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.indigo)
                            .clipShape(Circle())
                }
            }
        }
    }
}

#Preview {
    DraftRestart()
}

