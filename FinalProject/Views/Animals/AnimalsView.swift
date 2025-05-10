//
//  AnimalsView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 3/5/2568 BE.
//

import SwiftUI

struct AnimalsView: View {
    @StateObject var viewModel = AnimalsViewModel()
    
<<<<<<< Updated upstream
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                CardSwiperView(items: $viewModel.animals) { animal in
                    AnimalCardView(animal: animal)
                }
            }
        }
        .onAppear {
            viewModel.loadAnimals()
        }
    }
=======
	var body: some View {
		VStack {
			if viewModel.isLoading {
				ProgressView()
			} else {
				CardSwiperView(items: $viewModel.animals) { animal in
					AnimalsCardView(animal: animal)
				}
			}
		}
		.onAppear {
			viewModel.loadAnimals()
		}
	}
>>>>>>> Stashed changes
}
