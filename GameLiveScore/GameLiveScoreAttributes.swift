//
//  GameLiveScoreAttributes.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 29/10/2024.
//

import ActivityKit

struct GameLiveScoreAttributes: ActivityAttributes {
	public struct ContentState: Codable, Hashable {
		var homeTeamScore: Int
		var awayTeamScore: Int
		var lastEvent: String
	}

	var homeTeamLogo: String
	var awayTeamLogo: String
	var homeTeam: String
	var awayTeam: String
	var date: String
}
