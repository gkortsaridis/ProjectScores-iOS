//
//  ImageUtils.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 31/10/2024.
//

import UIKit

func downloadAndSaveImage(from urlString: String, fileName: String) {
	guard let url = URL(string: urlString) else { return }
	
	URLSession.shared.dataTask(with: url) { data, _, error in
		guard let data = data, error == nil else { return }
		
		if let image = UIImage(data: data) {
			saveImageToAppGroup(image, fileName: fileName)
		}
	}.resume()
}

func saveImageToAppGroup(_ image: UIImage, fileName: String) {
	guard let imageData = image.pngData() else { return }
	
	if let sharedURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.gr.gkortsaridis.projectscores") {
		let fileURL = sharedURL.appendingPathComponent(fileName)
		
		do {
			try imageData.write(to: fileURL)
			print("Image saved to shared container.")
		} catch {
			print("Error saving image: \(error)")
		}
	}
}
