//
//  GameLiveScoreLiveActivity.swift
//  GameLiveScore
//
//  Created by George Kortsaridis on 29/10/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct GameLiveScoreLiveActivity: Widget {
	
	@StateObject private var viewModel = GameLiveScoreViewModel()
	
	init() {
		print("INIT")
		viewModel.retrieveImages()
	}
	
	var body: some WidgetConfiguration {
			ActivityConfiguration(for: GameLiveScoreAttributes.self) { context in
				VStack(spacing: 8) {
							// Date and Time
							Text(context.attributes.date)
								.font(.caption2)
								.padding(4)
								.frame(maxWidth: .infinity)
								.background(Color.gray.opacity(0.2))
								.cornerRadius(8)
							
							// Team Logos and Scores
							HStack(alignment: .center) {
								Spacer()
														
								// Home Team Logo and Score
								VStack {
									if let arisLogo = viewModel.arisLogo,
									   let homeTeamImage = UIImage(contentsOfFile: arisLogo.path) {
										Image(uiImage: homeTeamImage)
											.resizable()
											.frame(width: 40, height: 40)
									} else {
										Text("Image not found") // Placeholder if the image isn't available
									}

									Text(context.attributes.homeTeam)
										.font(.subheadline)
										.foregroundColor(.primary)
								}
								
								// Home Team Score
								Text("\(context.state.homeTeamScore)")
									.font(.title)
									.fontWeight(.bold)
									.foregroundColor(.blue)
								
								// Separator
								Text("-")
									.font(.title)
									.fontWeight(.bold)
									.foregroundColor(.secondary)
								
								// Away Team Score
								Text("\(context.state.awayTeamScore)")
									.font(.title)
									.fontWeight(.bold)
									.foregroundColor(.red)
								
								// Away Team Logo and Score
								VStack {
									AsyncImage(url: URL(string: context.attributes.awayTeamLogo))
									.frame(width: 40, height: 40)
									
									Text(context.attributes.awayTeam)
										.font(.subheadline)
										.foregroundColor(.primary)
								}
								
								Spacer()
							}
							
							// Last Event
							Text(context.state.lastEvent)
								.font(.subheadline)
								.foregroundColor(.white)
								.padding(4)
								.frame(maxWidth: .infinity)
								.background(Color.mint)
								.cornerRadius(8)
							
						}
						.padding()
						.background(Color.white)
						.cornerRadius(16)
						.activityBackgroundTint(Color.white)
						.activitySystemActionForegroundColor(Color.black)
			} dynamicIsland: { context in
				DynamicIsland {
					DynamicIslandExpandedRegion(.leading) {
						Text("\(context.attributes.homeTeam) \(context.state.homeTeamScore)")
					}
					DynamicIslandExpandedRegion(.trailing) {
						Text("\(context.state.awayTeamScore) \(context.attributes.awayTeam)")
					}
					DynamicIslandExpandedRegion(.bottom) {
						HStack {
							Spacer(minLength: 4)
							Text(context.state.lastEvent)
								.font(.subheadline)
								.foregroundColor(.black)
							Spacer(minLength: 4)
						}
						.padding(4)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(.mint)
						Text(context.attributes.date)
							.font(.caption2)
							.padding(4)
					}
				} compactLeading: {
					Text("\(context.attributes.homeTeam) \(context.state.homeTeamScore)")
				} compactTrailing: {
					Text("\(context.state.awayTeamScore) \(context.attributes.awayTeam)")
				} minimal: {
					Text("⚽")
				}
				.widgetURL(URL(string: "https://markwarriors.github.io/"))
				.keylineTint(Color.red)
			}
		}
}

extension GameLiveScoreAttributes {
    fileprivate static var preview: GameLiveScoreAttributes {
		GameLiveScoreAttributes(homeTeamLogo: "https://media.api-sports.io/basketball/teams/606.png", awayTeamLogo: "https://media.api-sports.io/basketball/teams/613.png", homeTeam: "Aris", awayTeam: "Paok", date: "Kleanthis Vikelidis")
    }
}

extension GameLiveScoreAttributes.ContentState {
    fileprivate static var gameStarted: GameLiveScoreAttributes.ContentState {
		GameLiveScoreAttributes.ContentState(homeTeamScore: 0, awayTeamScore: 0, lastEvent: "Game Started")
     }
	
	fileprivate static var gameFinished: GameLiveScoreAttributes.ContentState {
		GameLiveScoreAttributes.ContentState(homeTeamScore: 82, awayTeamScore: 76, lastEvent: "Game Finished")
	 }
}

#Preview("Notification", as: .content, using: GameLiveScoreAttributes.preview) {
   GameLiveScoreLiveActivity()
} contentStates: {
	GameLiveScoreAttributes.ContentState.gameStarted
	GameLiveScoreAttributes.ContentState.gameFinished
}
