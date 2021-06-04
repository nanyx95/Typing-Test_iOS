//
//  Ranking.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 02/06/21.
//

import Foundation

struct Ranking: Codable {
	let id: String
	let user: String
	let wpm: Int
	let testDate: Double
}
