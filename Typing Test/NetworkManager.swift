//
//  NetworkManager.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 24/04/21.
//

import Foundation

class NetworkManager {
	
	static let shared = NetworkManager()
	private let baseURL = "https://fs-typing-test.herokuapp.com/api/v1/"
	
//	func getWords(number: Int, completed: @escaping (Result<[Word], NetworkError>) -> Void) {
//		let endpoint = baseURL + "words/\(number)"
//
//		guard let url = URL(string: endpoint) else {
//			completed(.failure(.invalidURL))
//			return
//		}
//
//		let task = URLSession.shared.dataTask(with: url) { data, response, error in
//			if let _ = error {
//				completed(.failure(.unableToComplete))
//				return
//			}
//
//			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//				completed(.failure(.invalidResponse))
//				return
//			}
//
//			guard let data = data else {
//				completed(.failure(.invalidData))
//				return
//			}
//
//			do {
//				let decoder = JSONDecoder()
//				let words = try decoder.decode([Word].self, from: data)
//				DispatchQueue.main.async { completed(.success(words)) }
//			} catch {
//				completed(.failure(.invalidData))
//			}
//		}
//
//		task.resume()
//	}
	
	func fetch<T: Decodable>(with path: String, generalType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
		let endpoint = baseURL + path
		
		guard let url = URL(string: endpoint) else {
			completion(.failure(.invalidURL))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let _ = error {
				completion(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else {
				completion(.failure(.invalidData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let words = try decoder.decode(T.self, from: data)
				DispatchQueue.main.async { completion(.success(words)) }
			} catch {
				completion(.failure(.invalidData))
			}
		}
		
		task.resume()
	}
	
}

enum NetworkError: String, Error {
	case invalidURL = "Invalid URL"
	case unableToComplete = "Unable to complete your request. Please check your internet connection"
	case invalidResponse = "Invalid response from the server. Please try again"
	case invalidData = "The data received from the server was invalid. Please try again"
}
