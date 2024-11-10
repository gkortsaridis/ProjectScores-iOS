//
//  GameLiveScoreViewModel.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 31/10/2024.
//

import Foundation

class GameLiveScoreViewModel: ObservableObject{
	
	@Published var isAnimating: Bool = false
	@Published var arisLogo : URL? = nil
	
	func retrieveImages() {
		print("RETRIEVE IMAGES")

		arisLogo = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.gr.gkortsaridis.projectscores")?.appendingPathComponent("aris-logo.png")
		
		print("LOGO: \(arisLogo?.path ?? "Not Found")")
	}
}
