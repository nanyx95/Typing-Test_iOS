//
//  RankingViewModel.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 02/06/21.
//

import Foundation

class RankingViewModel: ObservableObject {
	
	@Published var rankingToDisplay: [Ranking] = []
	@Published var isLoading: Bool = true
	var userRanking: Ranking?
	var topThree: [Ranking]?
	var userPosition: Int?
	
	init(userId: String) {
		let taskGroup = DispatchGroup()
		
		NetworkAPI.shared.getPositionById(userId: userId, dispatchGroup: taskGroup) { userPosition in
			self.userPosition = userPosition
		}
		NetworkAPI.shared.getRankingById(userId: userId, dispatchGroup: taskGroup) { userRanking in
			self.userRanking = userRanking
		}
		NetworkAPI.shared.getTopThree(dispatchGroup: taskGroup) { topThree in
			self.topThree = topThree
		}
		
		taskGroup.notify(queue: .main) {
			self.isLoading = false
			self.generateRankingToDisplay()
		}
	}
	
	private func generateRankingToDisplay() {
		if let topThree = self.topThree {
			rankingToDisplay = topThree
		}
		if let userPosition = self.userPosition {
			if userPosition > 3 {
				rankingToDisplay.append(userRanking!)
			}
		}
		rankingToDisplay.sort {
			$0.wpm > $1.wpm
		}
	}
	
	#if DEBUG
	func mockRankingForPreview() {
		isLoading = false
		rankingToDisplay.append(Ranking(id: "test1", user: "test1", wpm: 25, testDate: 1))
		rankingToDisplay.append(Ranking(id: "test2", user: "Test2", wpm: 5, testDate: 1))
	}
	#endif
	
}
