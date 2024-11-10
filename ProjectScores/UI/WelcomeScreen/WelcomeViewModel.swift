//
//  WelcomeViewModel.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 31/10/2024.
//

import Foundation

class WelcomeViewModel: ObservableObject{
	
	@Published var isAnimating: Bool = false
	
	func downloadImages() {
		downloadAndSaveImage(from: "https://media.api-sports.io/basketball/teams/606.png", fileName: "aris-logo.png")
	}
}
