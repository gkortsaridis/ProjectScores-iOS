//
//  CountrySelectionViewModel.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 10/11/2024.
//
import Foundation


class CountrySelectionViewModel: ObservableObject{
	
	@Published var isAnimating: Bool = false
	@Published var countriesResponse: ResponseCountries?

	init() {
		retrieveCountroes()
	}
	
	func retrieveCountroes() {
		print("RETRIEVING")
		
		APIServices.shared.retrieveCountries() { response in
			if let response = response {
				self.countriesResponse = response
				print(response)
			}
		} failure: { error in
			print(error)
		}
	}
		
}
	
