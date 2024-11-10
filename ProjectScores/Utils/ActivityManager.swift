//
//  ActivityManager.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 29/10/2024.
//

import ActivityKit
import Combine
import Foundation

final class ActivityManager: ObservableObject {
	@MainActor @Published private(set) var activityID: String?
	@MainActor @Published private(set) var activityToken: String?
	
	static let shared = ActivityManager()
	
	func start() async {
		await endActivity()
		await startNewLiveActivity()
	}
	
	private func startNewLiveActivity() async {
		let attributes = GameLiveScoreAttributes(homeTeamLogo: "https://media.api-sports.io/basketball/teams/606.png", awayTeamLogo: "https://media.api-sports.io/basketball/teams/613.png", homeTeam: "Aris", awayTeam: "Paok", date: "Kleanthis Vikelidis")
		let initialContentState = ActivityContent(state: GameLiveScoreAttributes.ContentState(homeTeamScore: 0, awayTeamScore: 0, lastEvent: "Match Start"), staleDate: nil)

		do {
			let activity = try Activity.request(attributes: attributes, content: initialContentState, pushType: .none)
			print("ACTIVITY IDENTIFIER: \(activity.id)")

			await MainActor.run { activityID = activity.id }
			
			for await data in activity.pushTokenUpdates {
				let token = data.map {String(format: "%02x", $0)}.joined()
				print("Activity token: \(token)")
				await MainActor.run { activityToken = token }
				// HERE SEND THE TOKEN TO THE SERVER
			}
		} catch {
			print("Failed to start Live Activity: \(error)")
		}
		
		
	}
	
	func updateActivityRandomly() async {
		guard let activityID = await activityID,
			  let runningActivity = Activity<GameLiveScoreAttributes>.activities.first(where: { $0.id == activityID }) else {
			return
		}
		let newRandomContentState = GameLiveScoreAttributes.ContentState(homeTeamScore: Int.random(in: 1...9),
																		  awayTeamScore: Int.random(in: 1...9),
																		  lastEvent: "Something random happened!")
		await runningActivity.update(using: newRandomContentState)
	}
	
	func endActivity() async {
		guard let activityID = await activityID,
			  let runningActivity = Activity<GameLiveScoreAttributes>.activities.first(where: { $0.id == activityID }) else {
			return
		}
		let initialContentState = GameLiveScoreAttributes.ContentState(homeTeamScore: 0,
																		awayTeamScore: 0,
																		lastEvent: "Match Start")

		await runningActivity.end(
			ActivityContent(state: initialContentState, staleDate: Date.distantFuture),
			dismissalPolicy: .immediate
		)

		await MainActor.run {
			self.activityID = nil
			self.activityToken = nil
		}
	}
	
	func cancelAllRunningActivities() async {
		for activity in Activity<GameLiveScoreAttributes>.activities {
			let initialContentState = GameLiveScoreAttributes.ContentState(homeTeamScore: 0,
																			awayTeamScore: 0,
																			lastEvent: "Match Start")
			
			await activity.end(
				ActivityContent(state: initialContentState, staleDate: Date()),
				dismissalPolicy: .immediate
			)
		}
		
		await MainActor.run {
			activityID = nil
			activityToken = nil
		}
	}
	
}
