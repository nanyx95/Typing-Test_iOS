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
	
	func saveScore(userScore: Ranking, finished: @escaping () -> Void) {
		let path = "ranking/save"
		
		NetworkManager.shared.post(with: path, generalType: userScore) { result in
			switch result {
			case .success(let score):
				print(score)
			case .failure(let error):
				print(error)
			}
			finished()
		}
	}
}
