//
//  ResponseCountries.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 10/11/2024.
//

struct Country: Codable {
	let id: Int
	let name: String
	let code: String?
	let flag: String?
}


struct ResponseCountries: Codable {
	let response: [Country]
}
