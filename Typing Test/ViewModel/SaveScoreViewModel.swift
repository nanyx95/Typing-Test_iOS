//
//  SaveScoreViewModel.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 02/06/21.
//

import Foundation

class SaveScoreViewModel: ObservableObject {
	
	var limit: Int = 8

	@Published var name: String = "" {
		didSet {
			if name.count > limit {
				name = String(name.prefix(limit))
			}
		}
	}
	
	init(userId: String) {
		NetworkAPI.shared.getRankingById(userId: userId) { userRanking in
			guard let userRanking = userRanking else { return }
			DispatchQueue.main.async {
				self.name = userRanking.user
			}
		}
	}
	
	func saveScore(userScore: Ranking, finished: @escaping () -> Void) {
		NetworkAPI.shared.saveScore(userScore: userScore) {
			finished()
		}
	}
	
}
