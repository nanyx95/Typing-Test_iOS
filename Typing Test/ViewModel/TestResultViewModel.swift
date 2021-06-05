//
//  TestResultViewModel.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 05/06/21.
//

import Foundation

class TestResultViewModel: ObservableObject {
	
	@Published var userRanking: Ranking?
	@Published var isLoading: Bool = true
	
	init(userId: String) {
		NetworkAPI.shared.getRankingById(userId: userId) { userRanking in
			DispatchQueue.main.async {
				self.isLoading = false
				self.userRanking = userRanking
			}
		}
	}
	
}
