//
//  GameLiveScoreBundle.swift
//  GameLiveScore
//
//  Created by George Kortsaridis on 29/10/2024.
//

import WidgetKit
import SwiftUI

@main
struct GameLiveScoreBundle: WidgetBundle {
    var body: some Widget {
        GameLiveScore()
        GameLiveScoreControl()
        GameLiveScoreLiveActivity()
    }
}
