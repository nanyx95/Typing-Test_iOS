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
			self.generateRankingToDisplay()
			self.isLoading = false
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
	
//	private func getPositionById(userId: String, dispatchGroup taskGroup: DispatchGroup) {
//		taskGroup.enter()
//		let path = "ranking/pos/\(userId)"
//
//		NetworkManager.shared.fetch(with: path, generalType: Int.self) { result in
//			switch result {
//			case .success(let pos):
//				self.userPosition = pos
//			case .failure(let error):
//				print("getPositionById: \(error)")
//			}
//			taskGroup.leave()
//		}
//	}
	
//	private func getRankingById(userId: String, dispatchGroup taskGroup: DispatchGroup) {
//		taskGroup.enter()
//		let path = "ranking/info/\(userId)"
//
//		NetworkManager.shared.fetch(with: path, generalType: Ranking.self) { result in
//			switch result {
//			case .success(let ranking):
//				self.userRanking = ranking
//			case .failure(let error):
//				print("getRankingById: \(error)")
//			}
//			taskGroup.leave()
//		}
//	}
	
//	private func getTopThree(dispatchGroup taskGroup: DispatchGroup) {
//		taskGroup.enter()
//		let path = "ranking/top"
//
//		NetworkManager.shared.fetch(with: path, generalType: [Ranking].self) { result in
//			switch result {
//			case .success(let topThree):
//				self.topThree = topThree
//			case .failure(let error):
//				print("getTopThree: \(error)")
//			}
//			taskGroup.leave()
//		}
//	}
	
}
