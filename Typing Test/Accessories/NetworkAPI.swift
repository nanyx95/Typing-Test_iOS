//
//  NetworkAPI.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 05/06/21.
//

import Foundation

class NetworkAPI {
	
	static let shared = NetworkAPI()
	
	func getWords(number: Int, completion: @escaping ([Word]) -> Void) {
		let path = "words/\(number)"
		
		NetworkManager.shared.fetch(with: path, generalType: [Word].self) { result in
			switch result {
			case .success(let words):
				completion(words)
			case .failure(let error):
				print("getWords: \(error)")
				completion([Word]())
			}
		}
	}
	
	func getWord(completion: @escaping (Word?) -> Void) {
		let path = "word"
		
		NetworkManager.shared.fetch(with: path, generalType: Word.self) { result in
			switch result {
			case .success(let word):
				completion(word)
			case .failure(let error):
				print("getWord: \(error)")
				completion(nil)
			}
		}
	}
	
	func getPositionById(userId: String, dispatchGroup taskGroup: DispatchGroup, completion: @escaping (Int?) -> Void) {
		taskGroup.enter()
		let path = "ranking/pos/\(userId)"
		
		NetworkManager.shared.fetch(with: path, generalType: Int.self) { result in
			switch result {
			case .success(let position):
				completion(position)
			case .failure(let error):
				print("getPositionById: \(error)")
				completion(nil)
			}
			taskGroup.leave()
		}
	}
	
	func getRankingById(userId: String, dispatchGroup taskGroup: DispatchGroup = DispatchGroup(), completion: @escaping (Ranking?) -> Void) {
		taskGroup.enter()
		let path = "ranking/info/\(userId)"
		
		NetworkManager.shared.fetch(with: path, generalType: Ranking.self) { result in
			switch result {
			case .success(let ranking):
				completion(ranking)
			case .failure(let error):
				print("getRankingById: \(error)")
				completion(nil)
			}
			taskGroup.leave()
		}
	}
	
	func getTopThree(dispatchGroup taskGroup: DispatchGroup, completion: @escaping ([Ranking]?) -> Void) {
		taskGroup.enter()
		let path = "ranking/top"
		
		NetworkManager.shared.fetch(with: path, generalType: [Ranking].self) { result in
			switch result {
			case .success(let topThree):
				completion(topThree)
			case .failure(let error):
				print("getTopThree: \(error)")
				completion(nil)
			}
			taskGroup.leave()
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
